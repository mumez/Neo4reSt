Class {
	#name : 'N4RawNode',
	#superclass : 'N4RawGraphObject',
	#instVars : [
		'labels'
	],
	#category : 'Neo4reSt-Cypher',
	#package : 'Neo4reSt-Cypher'
}

{ #category : 'accessing' }
N4RawNode >> addLabels: aCollection [
	self labels: (self labels asSet addAll: aCollection; yourself) asArray.
	^ self labels
]

{ #category : 'printing' }
N4RawNode >> elementName [
	^'N'
]

{ #category : 'testing' }
N4RawNode >> isNode [
	^true
]

{ #category : 'accessing' }
N4RawNode >> label [
	^ (self labels ifEmpty: [#(nil)]) at: 1.
	
]

{ #category : 'accessing' }
N4RawNode >> labels [
	^ labels
]

{ #category : 'accessing' }
N4RawNode >> labels: aCollection [
	labels := aCollection
]

{ #category : 'loading' }
N4RawNode >> loadFromDictionary: aDictionary [
	super loadFromDictionary: aDictionary.
	aDictionary at: 'labels' ifPresent: [:p | self labels: p].
]

{ #category : 'printing' }
N4RawNode >> printOn: aStream [
	self printElementHeaderOn: aStream.
	self labels ifEmpty: [ ^self ].
	aStream nextPutAll: self labels printString.
	
]

{ #category : 'accessing' }
N4RawNode >> removeLabels: aCollection [
	| removed |
	removed := self labels asOrderedCollection removeAllSuchThat: [:each | aCollection includes: each].
	self labels: removed asArray.
	^ self labels 
]
