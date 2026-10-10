# Feature: Neo4reSt - reuse the HTTP connection (stop creating a ZnClient per request)

Kanban issue: `1791533198214-neo4rest-http接続を再利用する-リクエスト毎の-znclient-生成をやめる`

## Goal

With `keepConnection` true (the default), repeated requests through the same `N4GraphDb` reuse one cached ZnClient (one TCP connection) instead of opening a new one per request. Per-request state such as the `X-Stream` header does not carry over between requests. `close` actually closes the cached connection. `keepConnection: false` keeps the old one-shot behavior. All Neo4reSt tests pass.

## Orchestration Shape

sequential, all via claude: implement connection reuse (TDD) → fix close chain + docs (TDD) → full test run → lint & review. Each phase is its own `seq:` block, so a retry stays local to that phase.

## Working Directory

`/home/mumez/git/Neo4reSt` (branch `feature/reuse-http-connection`, based on `develop`)

## Script

```Smalltalk
| script |
script := AgenticBrowser scriptBy: [ :builder |
	builder sharedDirectoryPath: '/home/mumez/git/Neo4reSt'.
	builder seq: {
		builder topicBy: [ :t |
			t title: 'Neo4reSt: reuse cached ZnClient (TDD)'.
			t prompt: 'You are working in the Neo4reSt Pharo Smalltalk repository (Tonel sources under src/). Use the smalltalk-developer skill workflow: edit Tonel .st files, import with st-import (absolute paths), and run tests with st-test. A Neo4j server is available for the existing Neo4reSt-Tests. Do NOT commit; leave changes uncommitted.

Problem: every Neo4j request opens a new TCP connection. N4PortableUtil >> httpClientDo: (src/Neo4reSt-Core/N4PortableUtil.class.st) calls self createHttpClient on every call, and N4PhPortableUtil (src/Neo4reSt-Pharo-Core/N4PhPortableUtil.class.st) does not override it. N4PhPortableUtil already declares an unused httpClient instance variable. N4Settings >> keepConnection (default true) only skips beOneShot in createHttpClient, so it has no real effect. The ZnClients created are never closed, so ESTABLISHED sockets pile up until GC. Measured: about 10ms per request with a new client vs 1.2-1.9ms with a reused client.

Task for this phase (connection reuse only; the close chain is the next phase):
1. Override httpClientDo: in N4PhPortableUtil:
   - keepConnection true: lazily create one ZnClient, keep it in the httpClient instance variable, and reuse it for every request.
   - keepConnection false: keep the old behavior. Create a new client with beOneShot for each request, do not store it, and close it after use (ensure:).
2. Make sure per-request state does not leak on the reused client. Known leak: ZnClient >> jsonPost:content:withStreaming: in src/Neo4reSt-Pharo-Core/ZnClient.extension.st only sets the X-Stream header when streaming is on, and it also sets contentWriter. On a reused client, a streaming request would leave X-Stream set for later non-streaming requests. Reset the request before each use. Check in the image whether ZnClient has resetRequest (or an equivalent) and what it clears. Make sure the entity, headers, and contentWriter do not carry over. Authentication is already set again on each call by httpSetAuthenticationInfoTo:.
3. Connection drops: check how ZnClient behaves when a kept-alive connection was closed by the server (keep-alive timeout or server restart). If Zn does not reconnect transparently, retry the request once on a fresh connection.
4. ZnClient is not thread-safe. Guard use of the cached client with a Mutex held by the N4PhPortableUtil instance (lazily initialized; critical: around the block). Note: the 401 retry inside httpJsonGet:on: and similar methods runs inside the same block, so a non-reentrant Semaphore would be fine too, but Mutex is safer.
5. The cache must live only on per-connection instances. N4RawClient >> portableUtil creates its own N4PortableUtil defaultClass new, and that is where the cached client must live. The shared singleton N4PortableUtil default (used by N4Url >> portableUtil only for string conversion) must not end up holding a connection. Verify that no HTTP request goes through the singleton. If one does, report it and do not cache on the singleton.
6. Add N4PhPortableUtil >> release, which closes the cached ZnClient (if any) and sets httpClient to nil, under the mutex.
Leave N4SqPortableUtil (Squeak) unchanged.

Follow TDD. First add failing tests in src/Neo4reSt-Tests (put them next to the existing N4BasicHttpTest / N4GraphDbTest, or in a new test class in that package, following the existing setUp/tearDown conventions):
- Two or more requests through the same N4RawClient / N4GraphDb use the identical ZnClient instance (==).
- With keepConnection false, no client is retained (httpClient stays nil) and requests still work.
- After a request with useStreaming true, the next request on the reused client does not send the X-Stream header.
- After release, httpClient is nil and the next request works on a new client.
Add an accessor (for example a testing-category httpClient getter) only if the tests need one. Then implement until these tests pass, and confirm the existing Neo4reSt-Tests still pass.

Report: files changed, what resetRequest (or equivalent) clears, how a dropped connection behaves, and test results.'.
			t goal: 'the new connection-reuse tests in Neo4reSt-Tests pass and existing Neo4reSt-Tests still pass' ]
	} agentBy: [ :a | a claude ].
	builder seq: {
		builder topicBy: [ :t |
			t title: 'Neo4reSt: fix close chain and document (TDD)'.
			t prompt: 'You are working in the Neo4reSt Pharo Smalltalk repository (Tonel sources under src/). Use the smalltalk-developer skill workflow: edit Tonel .st files, import with st-import (absolute paths), and run tests with st-test. Do NOT commit.

The previous phase made N4PhPortableUtil cache and reuse one ZnClient per instance and added N4PhPortableUtil >> release to close it. The previous result is included below. Now repair the close chain so that closing a graph db actually releases that connection. Current state (verify against the code first):
- N4GraphDb >> close (src/Neo4reSt-GraphModel/N4GraphDb.class.st) sends release to its httpClient. N4HttpClient does not implement release, so this is a no-op (Object>>release). Change it to send close.
- N4HttpClient >> close (src/Neo4reSt-Client/N4HttpClient.class.st) sends release to rawClient. N4RawClient does not implement release. Change it to send close. Do not lazily create a rawClient just to close it: the rawClient getter auto-creates, so read the instance variable directly.
- N4RawClient >> close already sends portableUtil release. Do not lazily create a portableUtil only to release it; use the instance variable.
- N4RestClient is obsolete. Do not fix its close method. First confirm with search_references_to_class that nothing outside N4RestClient references it. Then update its class comment to say it is obsolete and kept only for backward compatibility, and that N4HttpClient should be used instead.
- Update class comments (CRC style; see the smalltalk-commenter skill) for N4PhPortableUtil and N4GraphDb (or N4HttpClient) to state the following: with keepConnection true, each N4GraphDb/N4RawClient holds one persistent HTTP connection, released by close; access is serialized by a mutex; keepConnection false gives one-shot connections.

Follow TDD. First add failing tests in src/Neo4reSt-Tests:
- After a query on an N4GraphDb, sending close leaves the underlying portableUtil with no cached client (httpClient isNil), and the previously cached ZnClient is closed.
- Querying again after close works and uses a new ZnClient instance.
- close on a freshly created N4GraphDb that never sent a request does not error and does not create clients.
Then implement until green, and confirm the existing Neo4reSt-Tests still pass.

Report: files changed, the outcome of the N4RestClient reference check, and test results.'.
			t goal: 'the new close-chain tests in Neo4reSt-Tests pass and existing Neo4reSt-Tests still pass' ]
	} agentBy: [ :a | a claude ].
	builder seq: {
		builder topicBy: [ :t |
			t title: 'Neo4reSt: run full test suite'.
			t prompt: 'You are working in the Neo4reSt Pharo Smalltalk repository (Tonel sources under src/). Do NOT commit.

1. Make sure the image is in sync with src/. Re-import every changed package with st-import using absolute paths. Get the list of changed packages from git status / git diff (expected: Neo4reSt-Core, Neo4reSt-Pharo-Core, Neo4reSt-Client, Neo4reSt-GraphModel, Neo4reSt-Tests).
2. Run the whole Neo4reSt-Tests package with st-test (run_package_test), and report pass/fail/error counts. List every failing or erroring test by name, with the reason.
3. Check connection reuse empirically. In st-eval, create an N4GraphDb with the default settings and run RETURN 1 twenty times. Report the average time per call, and confirm that the portableUtil of its raw client holds one identical ZnClient throughout. If ss is available from the shell, also report the ESTABLISHED and TIME-WAIT socket counts to the Neo4j HTTP port before and after, then call close on the db.
4. If a test fails because of the changes on this branch, fix the cause (not the test, unless the test itself is wrong), re-import, and re-run until the suite is green. Explain each fix.

Report the final test counts, the timing and socket numbers, and any fixes made.' ]
	} agentBy: [ :a | a claude ].
	builder seq: {
		builder topicBy: [ :t |
			t title: 'Neo4reSt: lint and style review'.
			t prompt: 'You are working in the Neo4reSt Pharo Smalltalk repository (Tonel sources under src/). Do NOT commit.

Review every .st file changed on this branch (git diff --name-only develop, plus untracked files under src/):
1. Run the st-lint skill (or the smalltalk-validator MCP tools lint_tonel_smalltalk_from_file / validate_tonel_smalltalk_from_file) on each changed Tonel file, and fix every real finding.
2. Read the style guide section of the smalltalk-developer skill and check the changes against it: method categories, naming, no leftover debugging code, CRC class comments on changed or new classes, and matching the surrounding code idioms in Neo4reSt.
3. Check the design points: the cached ZnClient lives only on per-N4RawClient portableUtil instances (never on N4PortableUtil default); the mutex guards every use of the cached client including release; keepConnection false still gives one-shot clients that are closed after use; per-request state (the X-Stream header, entity, contentWriter) is reset between requests; and the close chain N4GraphDb >> close -> N4HttpClient >> close -> N4RawClient >> close -> portableUtil release works without lazily creating objects.
4. After any fix, re-import the affected packages with st-import, and re-run Neo4reSt-Tests with st-test to confirm it is still green.

Report the lint findings and fixes, any design issues found and how they were fixed, the final test counts, and a concise summary of the whole change set (files and what changed).' ]
	} agentBy: [ :a | a claude ] ].
script forkRunThen: [ :orc | Transcript crShow: 'Done: ' , orc result ]
	onTimeout: [ :timeoutStep :ex | Transcript crShow: 'Timed out: ' , timeoutStep printString ].
script register
```

## How to run

Paste the script above into a Pharo Playground, or ask the assistant to run it via st-eval. `forkRunThen:onTimeout:` runs the orchestration in the background and returns immediately. Watch for the completion block's report (for example in the Transcript), or the `onTimeout:` block's report if a step stalls. You can also check progress with `AbOrchestrationManager default orchestrationAt: <orchestration script id>`.
