Class {
	#name : 'N4Traversal',
	#superclass : 'Object',
	#instVars : [
		'startNode',
		'db',
		'returnType',
		'order',
		'relationships',
		'uniqueness',
		'pruneEvaluator',
		'returnFilter',
		'maxDepth'
	],
	#category : 'Neo4reSt-Traversal',
	#package : 'Neo4reSt-Traversal'
}

{ #category : 'constants' }
N4Traversal class >> builtInLanguageAssoc [
	^'language' -> 'builtin'
]

{ #category : 'constants' }
N4Traversal class >> directionAllAssoc [
	^'direction' -> 'all'
]

{ #category : 'constants' }
N4Traversal class >> directionInAssoc [
	^'direction' -> 'in'
]

{ #category : 'constants' }
N4Traversal class >> directionOutAssoc [
	^'direction' -> 'out'
]

{ #category : 'instance creation' }
N4Traversal class >> from: aNode [
	^self new startNode: aNode; yourself
]

{ #category : 'constants' }
N4Traversal class >> javascriptLanguageAssoc [
	^'language' -> 'javascript'
]

{ #category : 'constants' }
N4Traversal class >> nameAllAssoc [
	^'name' -> 'all'
]

{ #category : 'constants' }
N4Traversal class >> nameAllButStartNodeAssoc [
	^'name' -> 'all_but_start_node'
]

{ #category : 'constants' }
N4Traversal class >> nameNoneAssoc [
	^'name' -> 'none'
]

{ #category : 'converting' }
N4Traversal >> asDictionary [
	"order relationships uniqueness pruneEvaluator returnFilter maxDepth"
	| dict |
	dict := Dictionary new.
	self order ifNotNil: [dict at: 'order' put: self order].
	self relationships ifNotNil: [dict at: 'relationships' put: self relationships].
	self uniqueness ifNotNil: [dict at: 'uniqueness' put: self uniqueness].
	self pruneEvaluator ifNotNil: [dict at: 'pruneEvaluator' put: self pruneEvaluator].
	self returnFilter ifNotNil: [dict at: 'returnFilter' put: self returnFilter].
	self maxDepth ifNotNil: [dict at: 'maxDepth' put: self maxDepth].
	^dict
]

{ #category : 'accessing-convenient' }
N4Traversal >> breadthFirst [
	self order: 'breadth_first'
]

{ #category : 'enumerating' }
N4Traversal >> collect: aBlock [
	^ self traverse collect: aBlock
]

{ #category : 'accessing' }
N4Traversal >> db [
	^self startNode db
]

{ #category : 'accessing-convenient' }
N4Traversal >> depthFirst [
	self order: 'depth_first'
]

{ #category : 'enumerating' }
N4Traversal >> detect: aBlock ifNone: noneBlock [
	^ self traverse detect: aBlock ifNone: noneBlock
]

{ #category : 'enumerating' }
N4Traversal >> do: aBlock [
	^ self traverse do: aBlock
]

{ #category : 'enumerating' }
N4Traversal >> first [
	^ self traverse first
]

{ #category : 'accessing-convenient' }
N4Traversal >> incoming: type [
	self relIn: type
]

{ #category : 'testing' }
N4Traversal >> isEmpty [
	^ self traverse isEmpty
]

{ #category : 'accessing' }
N4Traversal >> maxDepth [
	"Answer the value of maxDepth"

	^ maxDepth
]

{ #category : 'accessing' }
N4Traversal >> maxDepth: anObject [
	"Set the value of maxDepth"

	maxDepth := anObject
]

{ #category : 'accessing-convenient' }
N4Traversal >> noPrune [
	self pruneEvaluator: (N4Dictionary with: self class builtInLanguageAssoc with: self class nameNoneAssoc)
]

{ #category : 'uniqueness' }
N4Traversal >> nodeGlobalUnique [
	self uniqueness: 'node_global'
]

{ #category : 'uniqueness' }
N4Traversal >> nodePathUnique [
	self uniqueness: 'node_path'
]

{ #category : 'uniqueness' }
N4Traversal >> nodeRecentUnique [
	self uniqueness: 'node_recent'
]

{ #category : 'uniqueness' }
N4Traversal >> noneUnique [
	self uniqueness: 'none'
]

{ #category : 'accessing' }
N4Traversal >> order [
	"Answer the value of order"

	^ order
]

{ #category : 'accessing' }
N4Traversal >> order: anObject [
	"Set the value of order"

	order := anObject
]

{ #category : 'accessing-convenient' }
N4Traversal >> outgoing: type [
	self relOut: type
]

{ #category : 'accessing' }
N4Traversal >> pruneEvaluator [
	"Answer the value of pruneEvaluator"

	^ pruneEvaluator
]

{ #category : 'accessing' }
N4Traversal >> pruneEvaluator: anObject [
	"Set the value of pruneEvaluator"

	pruneEvaluator := anObject
]

{ #category : 'enumerating' }
N4Traversal >> reject: aBlock [
	^ self traverse reject: aBlock
]

{ #category : 'accessing-convenient' }
N4Traversal >> relAll: type [
	self relationships add: (N4Dictionary with: self class directionAllAssoc with: 'type' -> type)
]

{ #category : 'uniqueness' }
N4Traversal >> relGlobalUnique [
	self uniqueness: 'relationship_global'
]

{ #category : 'accessing-convenient' }
N4Traversal >> relIn: type [
	self relationships add: (N4Dictionary with: self class directionInAssoc with: 'type' -> type)
]

{ #category : 'accessing-convenient' }
N4Traversal >> relOut: type [
	self relationships add: (N4Dictionary with: self class directionOutAssoc with: 'type' -> type)
]

{ #category : 'uniqueness' }
N4Traversal >> relPathUnique [
	self uniqueness: 'relationship_path'
]

{ #category : 'uniqueness' }
N4Traversal >> relRecentUnique [
	self uniqueness: 'relationship_recent'
]

{ #category : 'accessing' }
N4Traversal >> relationships [

	^ relationships ifNil: [relationships := OrderedCollection new]
]

{ #category : 'accessing' }
N4Traversal >> relationships: anObject [
	"Set the value of relationships"

	relationships := anObject
]

{ #category : 'accessing' }
N4Traversal >> returnFilter [
	"Answer the value of returnFilter"

	^ returnFilter
]

{ #category : 'accessing' }
N4Traversal >> returnFilter: anObject [
	"Set the value of returnFilter"

	returnFilter := anObject
]

{ #category : 'return types' }
N4Traversal >> returnFullpath [
	self returnType: 'fullpath'
]

{ #category : 'return types' }
N4Traversal >> returnNode [
	self returnType: 'node'
]

{ #category : 'return types' }
N4Traversal >> returnPath [
	self returnType: 'path'
]

{ #category : 'return types' }
N4Traversal >> returnRelationship [
	self returnType: 'relationship'
]

{ #category : 'accessing' }
N4Traversal >> returnType [
	 returnType ifNil: [self returnNode].
	^returnType
]

{ #category : 'accessing' }
N4Traversal >> returnType: anObject [
	"Set the value of returnType"

	returnType := anObject
]

{ #category : 'enumerating' }
N4Traversal >> select: aBlock [
	^ self traverse select: aBlock
]

{ #category : 'enumerating' }
N4Traversal >> size [
	^ self traverse size
]

{ #category : 'accessing' }
N4Traversal >> startNode [
	"Answer the value of startNode"

	^ startNode
]

{ #category : 'accessing' }
N4Traversal >> startNode: aNode [
	startNode := aNode
]

{ #category : 'actions' }
N4Traversal >> traverse [
	^self traverseFrom: self startNode
]

{ #category : 'actions' }
N4Traversal >> traverseFrom: aNode [
	"to do - implementing traverser"
	| json |
	json := self db httpClient traverseFrom: startNode id using: self.
	^N4Traverser json: json for: self
]

{ #category : 'accessing' }
N4Traversal >> uniqueness [
	"Answer the value of uniqueness"

	^ uniqueness
]

{ #category : 'accessing' }
N4Traversal >> uniqueness: anObject [
	"Set the value of uniqueness"

	uniqueness := anObject
]

{ #category : 'accessing-convenient' }
N4Traversal >> wantAll [
	self returnFilter: (N4Dictionary with: self class builtInLanguageAssoc with: self class nameAllAssoc) 
]

{ #category : 'accessing-convenient' }
N4Traversal >> wantAllButStartNode [
	self returnFilter: (N4Dictionary with: self class builtInLanguageAssoc with: self class nameAllButStartNodeAssoc) 
]
