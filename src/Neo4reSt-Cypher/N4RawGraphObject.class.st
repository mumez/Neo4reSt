Class {
	#name : 'N4RawGraphObject',
	#superclass : 'Object',
	#instVars : [
		'id',
		'properties'
	],
	#category : 'Neo4reSt-Cypher',
	#package : 'Neo4reSt-Cypher'
}

{ #category : 'instance creation' }
N4RawGraphObject class >> loadFromDictionary: aDictionary [
	| inst |
	inst := self new.
	inst loadFromDictionary: aDictionary.
	^inst
]

{ #category : 'comparing' }
N4RawGraphObject >> = other [
	^ self class = other class and: [self id = other id]
]

{ #category : 'properties' }
N4RawGraphObject >> at: propName [ 
	"shortcut"
	^self propertyAt: propName
]

{ #category : 'printing' }
N4RawGraphObject >> elementName [
	^self class name
]

{ #category : 'comparing' }
N4RawGraphObject >> hash [
	^self id hash
]

{ #category : 'accessing' }
N4RawGraphObject >> id [
	"Answer the value of id"

	^ id
]

{ #category : 'accessing' }
N4RawGraphObject >> id: anObject [
	"Set the value of id"

	id := anObject
]

{ #category : 'testing' }
N4RawGraphObject >> isNode [
	^false
]

{ #category : 'testing' }
N4RawGraphObject >> isRelationship [
	^false
]

{ #category : 'loading' }
N4RawGraphObject >> loadFromDictionary: aDictionary [
	aDictionary at: 'id' ifPresent: [:p | self id: p asInteger].
	aDictionary at: 'properties' ifPresent: [:p | self properties: p].
]

{ #category : 'properties' }
N4RawGraphObject >> mergeProperties: props [
	props asDictionary keysAndValuesDo: [ :k :v |
		self propertyAt: k put: v 
	]
]

{ #category : 'printing' }
N4RawGraphObject >> printElementHeaderOn: aStream [
	aStream nextPutAll: self elementName.
	aStream nextPut: $:.
	aStream nextPutAll: self id printString
]

{ #category : 'printing' }
N4RawGraphObject >> printOn: aStream [
	self printElementHeaderOn: aStream
]

{ #category : 'properties' }
N4RawGraphObject >> properties [
	^ properties ifNil: [ properties := Dictionary new ]
]

{ #category : 'properties' }
N4RawGraphObject >> properties: props [
	props ifNil: [ ^ properties := nil ].
	properties := props asDictionary
]

{ #category : 'properties' }
N4RawGraphObject >> propertyAt: propName [
	^ self properties at: propName ifAbsent: [  ]
]

{ #category : 'properties' }
N4RawGraphObject >> propertyAt: propName put: value [
	^ self properties at: propName put: value
]

{ #category : 'properties' }
N4RawGraphObject >> removePropertyAt: propName [
	^ self removePropertyAt: propName ifAbsent: []
]

{ #category : 'properties' }
N4RawGraphObject >> removePropertyAt: propName ifAbsent: aBlock [
	^ self properties removeKey: propName ifAbsent: aBlock
]
