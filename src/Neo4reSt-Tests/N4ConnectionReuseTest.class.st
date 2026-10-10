Class {
	#name : 'N4ConnectionReuseTest',
	#superclass : 'TestCase',
	#category : 'Neo4reSt-Tests',
	#package : 'Neo4reSt-Tests'
}

{ #category : 'accessing' }
N4ConnectionReuseTest >> newSettingsKeepConnection: keepBoolean [
	| settings |
	settings := N4GraphDbTest defaultSettings deepCopy.
	settings keepConnection: keepBoolean.
	^ settings
]

{ #category : 'private' }
N4ConnectionReuseTest >> withDbKeepConnection: keepBoolean do: aBlock [
	^ self withDbSettings: (self newSettingsKeepConnection: keepBoolean) do: aBlock
]

{ #category : 'private' }
N4ConnectionReuseTest >> withDbSettings: settings do: aBlock [
	"Note: N4GraphDb>>release/close does not actually reach N4PhPortableUtil>>release
	(N4HttpClient>>close and N4RawClient both lack a real release/close chain - that
	wiring is a separate, not-yet-done phase). Release the portableUtil directly here
	so the underlying ZnClient/socket is always cleaned up after each test."
	| db |
	db := N4GraphDb settings: settings.
	[ aBlock value: db ] ensure: [ db httpClient portableUtil release ]
]

{ #category : 'testing' }
N4ConnectionReuseTest >> testKeepConnectionFalseDoesNotRetainClient [
	self withDbKeepConnection: false do: [ :db |
		db allLabels.
		self assert: db httpClient portableUtil httpClient isNil.
		db allLabels.
		self assert: db httpClient portableUtil httpClient isNil.
	]
]

{ #category : 'testing' }
N4ConnectionReuseTest >> testReleaseDropsCachedClientAndNextRequestWorks [
	self withDbKeepConnection: true do: [ :db |
		| firstClient |
		db allLabels.
		firstClient := db httpClient portableUtil httpClient.
		self assert: firstClient notNil.
		db httpClient portableUtil release.
		self assert: db httpClient portableUtil httpClient isNil.
		db allLabels.
		self assert: db httpClient portableUtil httpClient notNil.
		self deny: db httpClient portableUtil httpClient == firstClient.
	]
]

{ #category : 'testing' }
N4ConnectionReuseTest >> testSameConnectionReusedAcrossRequests [
	self withDbKeepConnection: true do: [ :db |
		| firstClient secondClient |
		db allLabels.
		firstClient := db httpClient portableUtil httpClient.
		self assert: firstClient notNil.
		db allLabels.
		secondClient := db httpClient portableUtil httpClient.
		self assert: firstClient == secondClient.
	]
]

{ #category : 'testing' }
N4ConnectionReuseTest >> testCloseOnFreshDbDoesNotErrorOrCreateClients [
	| settings db |
	settings := self newSettingsKeepConnection: true.
	db := N4GraphDb settings: settings.
	db close.
	self assert: db httpClient portableUtil httpClient isNil.
]

{ #category : 'testing' }
N4ConnectionReuseTest >> testCloseReleasesCachedClientAndNewRequestUsesNewClient [
	self withDbKeepConnection: true do: [ :db |
		| firstClient secondClient |
		db allLabels.
		firstClient := db httpClient portableUtil httpClient.
		self assert: firstClient notNil.
		db close.
		self assert: db httpClient portableUtil httpClient isNil.
		self deny: firstClient isConnected.
		db allLabels.
		secondClient := db httpClient portableUtil httpClient.
		self assert: secondClient notNil.
		self deny: secondClient == firstClient.
	]
]

{ #category : 'testing' }
N4ConnectionReuseTest >> testStreamingHeaderDoesNotLeakToNextRequest [
	| settings |
	settings := self newSettingsKeepConnection: true.
	settings useStreaming: true.
	self withDbSettings: settings do: [ :db |
		| cli node |
		node := db createNodeLabeled: 'N4ConnectionReuseTestTemp'.
		cli := db httpClient portableUtil httpClient.
		self assert: (cli request headers includesKey: 'X-Stream').
		settings useStreaming: false.
		db allLabels.
		self deny: (cli request headers includesKey: 'X-Stream').
		node delete.
	]
]
