Class {
	#name : 'N4BasicCypherTest',
	#superclass : 'TestCase',
	#category : 'Neo4reSt-Tests',
	#package : 'Neo4reSt-Tests'
}

{ #category : 'private' }
N4BasicCypherTest >> dbDo: aBlock [
	| db |
	db := N4GraphDb settings: self settings.
	[aBlock value: db ]
		ifCurtailed: [ db release ]
]

{ #category : 'accessing' }
N4BasicCypherTest >> settings [
	^N4GraphDbTest defaultSettings
]

{ #category : 'testing' }
N4BasicCypherTest >> testReturnFromCypher [
	self dbDo: [ :db | 
		| cypher resp |
		cypher := 'WITH 123 as A RETURN A'.
		resp := db runCypher: cypher.
		self assert: resp hasErrors not.
		self assert: resp oneValue equals: 123.
	].
]

{ #category : 'testing' }
N4BasicCypherTest >> testReturnFromLargeCypher [
	self dbDo: [ :db | 
		| padding mSecs cypher resp |
		padding := String new: 1024 * 100 withAll: Character space.
		mSecs := Time millisecondClockValue.
		cypher := ('WITH ', mSecs asString, ' as A', padding, 'RETURN A').
		resp := db runCypher: cypher.
		self assert: resp hasErrors not.
		self assert: resp oneValue equals: mSecs.
	].
]

{ #category : 'testing' }
N4BasicCypherTest >> testRunCypherWithParams [
	self dbDo: [ :db | | resp cypherWithParams |
		resp := db runCypher: 'RETURN 1'.
		self assert: resp oneValue equals: 1.

		resp := db runCypher: (CyReturn of: 2 asCypherValue).
		self assert: resp oneValue equals: 2.

		resp := db runCypher: 'RETURN $p' arguments: {#p->3}.
		self assert: resp oneValue equals: 3.

		cypherWithParams := CyReturn of: 'p' asCypherParameter, 'q' asCypherParameter.
		resp := db runCypher: cypherWithParams arguments: {#p->4. #q->5}.
		self assert: resp values equals: #(4 5).
	].
]

{ #category : 'testing' }
N4BasicCypherTest >> testRunCyphersAtOnce [
	self dbDo: [ :db | | resp cyphersWithParam |
		resp := db runCyphers: #('RETURN 1' 'RETURN 2').
		self assert: resp allOneValues equals: #(1 2).
		
		cyphersWithParam := #(3 4) collect: [:each | CyReturn of: each asCypherValue].
		resp := db runCyphers: cyphersWithParam.
		self assert: resp allOneValues equals: #(3 4).
		
		resp := db runCyphersBy: [:cyphers |
			cyphers cypher: 'RETURN 10'.
			cyphers cypher: (CyReturn of: 20 asCypherValue).
			cyphers cypher: 'RETURN $p' arguments: {#p->30}.
			cyphers cypher: (CyReturn of: 'p' asCypherParameter) arguments: {#p->40}.
		].
		self assert: resp allOneValues equals: #(10 20 30 40).
	].
]
