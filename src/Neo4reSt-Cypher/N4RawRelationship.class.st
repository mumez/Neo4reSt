Class {
	#name : 'N4RawRelationship',
	#superclass : 'N4RawGraphObject',
	#instVars : [
		'type',
		'relativeDirection',
		'startNodeId',
		'endNodeId'
	],
	#category : 'Neo4reSt-Cypher',
	#package : 'Neo4reSt-Cypher'
}

{ #category : 'actions' }
N4RawRelationship >> beBoth [
	^self relativeDirection: #both
]

{ #category : 'actions' }
N4RawRelationship >> beIn [
	^self relativeDirection: #in
]

{ #category : 'actions' }
N4RawRelationship >> beOut [
	^self relativeDirection: #out
]

{ #category : 'accessing' }
N4RawRelationship >> relativeDirection [

	^ relativeDirection
]

{ #category : 'accessing' }
N4RawRelationship >> relativeDirection: anObject [

	relativeDirection := anObject
]

{ #category : 'printing' }
N4RawRelationship >> elementName [
	^'R'
]

{ #category : 'accessing' }
N4RawRelationship >> endNodeId [

	^ endNodeId
]

{ #category : 'accessing' }
N4RawRelationship >> endNodeId: anObject [

	endNodeId := anObject
]

{ #category : 'testing' }
N4RawRelationship >> isRelationship [
	^true
]

{ #category : 'loading' }
N4RawRelationship >> loadFromDictionary: aDictionary [
	super loadFromDictionary: aDictionary.
	aDictionary at: 'type' ifPresent: [:p | self type: p].
	aDictionary at: 'startNode' ifPresent: [:p | self startNodeId: p asInteger].
	aDictionary at: 'endNode' ifPresent: [:p | self endNodeId: p asInteger].
]

{ #category : 'printing' }
N4RawRelationship >> printOn: aStream [
	self printElementHeaderOn: aStream.
	aStream space.
	aStream nextPut: $(.
	aStream nextPutAll: self startNodeId asString.
	aStream nextPut: $).
	aStream space.
	self relativeDirection == #in ifTrue: [aStream nextPut: $<].
	aStream nextPut: $-.
	aStream nextPutAll: self type asString.
	aStream nextPut: $-.
	self relativeDirection == #out ifTrue: [aStream nextPut: $>].
	aStream space.
	aStream nextPut: $(.
	aStream nextPutAll: self endNodeId asString.
	aStream nextPut: $).
]

{ #category : 'accessing' }
N4RawRelationship >> startNodeId [

	^ startNodeId
]

{ #category : 'accessing' }
N4RawRelationship >> startNodeId: anObject [

	startNodeId := anObject
]

{ #category : 'accessing' }
N4RawRelationship >> type [

	^ type
]

{ #category : 'accessing' }
N4RawRelationship >> type: anObject [

	type := anObject
]
