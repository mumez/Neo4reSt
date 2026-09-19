Class {
	#name : 'N4CypherGraphResult',
	#superclass : 'Object',
	#instVars : [
		'nodes',
		'relationships'
	],
	#category : 'Neo4reSt-Cypher',
	#package : 'Neo4reSt-Cypher'
}

{ #category : 'instance creation' }
N4CypherGraphResult class >> fromDictionary: aDictionary [
	| inst |
	inst := self new.
	aDictionary at: #nodes ifPresent: [ :nodes | inst loadNodes: nodes ].
	aDictionary at: #relationships ifPresent: [ :relationships | inst loadRelationships: relationships ].
	^ inst
]

{ #category : 'accessing' }
N4CypherGraphResult >> firstOrNilOf: aCollection [
	^self portableUtil firstOrNilOf: aCollection
]

{ #category : 'loading' }
N4CypherGraphResult >> loadNodeFrom: nodeDict [
	^ N4RawNode loadFromDictionary: nodeDict
]

{ #category : 'loading' }
N4CypherGraphResult >> loadNodes: nodeDicts [
	nodes := nodeDicts collect: [ :each | self loadNodeFrom: each ]
]

{ #category : 'loading' }
N4CypherGraphResult >> loadRelationshipFrom: relationshipDict [
	^ N4RawRelationship loadFromDictionary: relationshipDict
]

{ #category : 'loading' }
N4CypherGraphResult >> loadRelationships: relationshipDicts [
	relationships := relationshipDicts collect: [ :each | self loadRelationshipFrom: each ]
]

{ #category : 'accessing' }
N4CypherGraphResult >> node [
	^self firstOrNilOf: self nodes
]

{ #category : 'accessing' }
N4CypherGraphResult >> nodes [

	^ nodes
]

{ #category : 'accessing' }
N4CypherGraphResult >> portableUtil [
	^ N4PortableUtil default
]

{ #category : 'accessing' }
N4CypherGraphResult >> relationship [
	^self firstOrNilOf: self relationships
]

{ #category : 'accessing' }
N4CypherGraphResult >> relationships [

	^ relationships
]
