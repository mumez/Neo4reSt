Class {
	#name : 'N4ConnectionReuseTest',
	#superclass : 'TestCase',
	#category : 'Neo4reSt-Tests',
	#package : 'Neo4reSt-Tests'
}

{ #category : 'testing' }
N4ConnectionReuseTest class >> isAbstract [
	"These tests exercise the cached ZnClient of N4PhPortableUtil (Pharo only).
	Exclude them on other dialects (e.g. Squeak) until connection reuse is implemented there"
	^ N4PortableUtil defaultClass name ~= #N4PhPortableUtil
]

{ #category : 'private' }
N4ConnectionReuseTest >> cachedClientOf: aGraphDb [
	"The single seam through which these tests observe the HTTP client kept by aGraphDb"
	^ aGraphDb httpClient portableUtil httpClient
]

{ #category : 'accessing' }
N4ConnectionReuseTest >> newSettingsKeepConnection: keepBoolean [
	| settings |
	settings := N4GraphDbTest defaultSettings deepCopy.
	settings keepConnection: keepBoolean.
	^ settings
]

{ #category : 'testing' }
N4ConnectionReuseTest >> testCloseOnFreshDbDoesNotErrorOrCreateClients [
	| db |
	db := N4GraphDb settings: (self newSettingsKeepConnection: true).
	db close.
	self assert: (self cachedClientOf: db) isNil
]

{ #category : 'testing' }
N4ConnectionReuseTest >> testCloseReleasesCachedClientAndNewRequestUsesNewClient [
	self withDbKeepConnection: true do: [ :db |
		| firstClient secondClient |
		db allLabels.
		firstClient := self cachedClientOf: db.
		self assert: firstClient notNil.
		db close.
		self assert: (self cachedClientOf: db) isNil.
		self deny: firstClient isConnected.
		db allLabels.
		secondClient := self cachedClientOf: db.
		self assert: secondClient notNil.
		self deny: secondClient == firstClient ]
]

{ #category : 'testing' }
N4ConnectionReuseTest >> testKeepConnectionFalseDoesNotRetainClient [
	self withDbKeepConnection: false do: [ :db |
		db allLabels.
		self assert: (self cachedClientOf: db) isNil.
		db allLabels.
		self assert: (self cachedClientOf: db) isNil ]
]

{ #category : 'testing' }
N4ConnectionReuseTest >> testRequestRecoversAfterConnectionIsDropped [
	self withDbKeepConnection: true do: [ :db |
		| cli |
		db allLabels.
		cli := self cachedClientOf: db.
		"Simulate the server dropping the kept-alive connection (keep-alive timeout, restart)"
		(cli instVarNamed: #connection) close.
		self deny: cli isConnected.
		self shouldnt: [ db allLabels ] raise: Error.
		self assert: (self cachedClientOf: db) == cli.
		self assert: cli isConnected ]
]

{ #category : 'testing' }
N4ConnectionReuseTest >> testSameConnectionReusedAcrossRequests [
	self withDbKeepConnection: true do: [ :db |
		| firstClient |
		db allLabels.
		firstClient := self cachedClientOf: db.
		self assert: firstClient notNil.
		db allLabels.
		self assert: (self cachedClientOf: db) == firstClient ]
]

{ #category : 'testing' }
N4ConnectionReuseTest >> testStreamingHeaderDoesNotLeakToNextRequest [
	| settings |
	settings := self newSettingsKeepConnection: true.
	settings useStreaming: true.
	self withDbSettings: settings do: [ :db |
		| cli node |
		node := db createNodeLabeled: 'N4ConnectionReuseTestTemp'.
		[
			cli := self cachedClientOf: db.
			self assert: (cli request headers includesKey: 'X-Stream').
			settings useStreaming: false.
			db allLabels.
			self deny: (cli request headers includesKey: 'X-Stream')
		] ensure: [ node delete ] ]
]

{ #category : 'private' }
N4ConnectionReuseTest >> withDbKeepConnection: keepBoolean do: aBlock [
	^ self withDbSettings: (self newSettingsKeepConnection: keepBoolean) do: aBlock
]

{ #category : 'private' }
N4ConnectionReuseTest >> withDbSettings: settings do: aBlock [
	| db |
	db := N4GraphDb settings: settings.
	[ aBlock value: db ] ensure: [ db close ]
]
