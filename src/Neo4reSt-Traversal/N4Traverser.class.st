Class {
	#name : 'N4Traverser',
	#superclass : 'Object',
	#instVars : [
		'traversal',
		'json',
		'index'
	],
	#category : 'Neo4reSt-Traversal',
	#package : 'Neo4reSt-Traversal'
}

{ #category : 'instance creation' }
N4Traverser class >> json: jsonObject for: traversal [ 
	^ self new json: jsonObject;
		 traversal: traversal;
		 yourself
]

{ #category : 'accessing' }
N4Traverser >> at: anInteger [
	self index: anInteger.
	^ self next
]

{ #category : 'stream-like' }
N4Traverser >> atEnd [
	^self index > self json size
]

{ #category : 'enumerating' }
N4Traverser >> collect: aBlock [
	| ord |
	ord := OrderedCollection new: self json size.
	[self atEnd] whileFalse: [
		ord add: (aBlock value: self next)
	].
	^ord
]

{ #category : 'accessing' }
N4Traverser >> db [
	^self traversal db
]

{ #category : 'enumerating' }
N4Traverser >> detect: aBlock ifNone: noneBlock [
	[self atEnd] whileFalse: [ | elem |
		(aBlock value: (elem := self next)) ifTrue: [^elem]
	].
	^noneBlock value
]

{ #category : 'enumerating' }
N4Traverser >> do: aBlock [
	[self atEnd] whileFalse: [
		aBlock value: self next
	]
]

{ #category : 'accessing' }
N4Traverser >> first [
	self index: 1.
	^ self next
]

{ #category : 'accessing' }
N4Traverser >> firstOrNil [
	self isEmpty ifTrue: [^nil].
	^ self first
]

{ #category : 'accessing' }
N4Traverser >> index [
	"Answer the value of index"

	^ index ifNil: [index := 1]
]

{ #category : 'accessing' }
N4Traverser >> index: anObject [
	"Set the value of index"

	index := anObject
]

{ #category : 'testing' }
N4Traverser >> isEmpty [
	^self json isEmpty
]

{ #category : 'accessing' }
N4Traverser >> json [
	"Answer the value of json"

	^ json
]

{ #category : 'accessing' }
N4Traverser >> json: anObject [
	"Set the value of json"

	json := anObject
]

{ #category : 'stream-like' }
N4Traverser >> next [
	| parsed |
	parsed := self parse: (self json at: self index).
	self index: self index + 1.
	^parsed
]

{ #category : 'private' }
N4Traverser >> parse: jsonElement [
	self returnType = 'node' ifTrue: [^(self db nodeClass json: jsonElement) db: self db].
	self returnType = 'relationship' ifTrue: [^(self db relationshipClass json: jsonElement for: self startNode) db: self db].
	
	self flag: 'todo'.
	"self returnType = 'path' ifTrue: [].
	self returnType = 'fullpath' ifTrue: []."
	
]

{ #category : 'enumerating' }
N4Traverser >> reject: aBlock [
	| ord |
	ord := OrderedCollection new.
	[self atEnd] whileFalse: [ | elem |
		(aBlock value: (elem := self next)) ifFalse: [ord add: elem]
	].
	^ord
]

{ #category : 'accessing' }
N4Traverser >> returnType [
	^self traversal returnType
]

{ #category : 'enumerating' }
N4Traverser >> select: aBlock [
	| ord |
	ord := OrderedCollection new.
	[self atEnd] whileFalse: [ | elem |
		(aBlock value: (elem := self next)) ifTrue: [ord add: elem]
	].
	^ord
]

{ #category : 'accessing' }
N4Traverser >> size [
	^self json size
]

{ #category : 'accessing' }
N4Traverser >> startNode [
	^self traversal startNode
]

{ #category : 'accessing' }
N4Traverser >> traversal [
	"Answer the value of traversal"

	^ traversal
]

{ #category : 'accessing' }
N4Traverser >> traversal: anObject [
	"Set the value of traversal"

	traversal := anObject
]
