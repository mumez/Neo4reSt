Class {
	#name : 'N4CypherResult',
	#superclass : 'Object',
	#instVars : [
		'columns',
		'data',
		'stats'
	],
	#category : 'Neo4reSt-Cypher',
	#package : 'Neo4reSt-Cypher'
}

{ #category : 'instance creation' }
N4CypherResult class >> json: jsonObject [
	| inst |
	inst := self new.
	inst columns: (jsonObject at: 'columns' ifAbsent:[]).
	inst data: (jsonObject at: 'data' ifAbsent:[]).
	inst stats: (jsonObject at: 'stats' ifAbsent:[]).
	^inst
]

{ #category : 'accessing' }
N4CypherResult >> allDataDo: aBlock [
	^ self data do: aBlock
]

{ #category : 'accessing' }
N4CypherResult >> allGraphsDo: aBlock [
	^ self
		  allDataDo: [ :dt | 
			  dt
				  at: #graph
				  ifPresent: [ :p | 
				  aBlock value: (N4CypherGraphResult fromDictionary: p) ] ]
]

{ #category : 'accessing-rows' }
N4CypherResult >> allMappedValues [
	| mappedValues |
	mappedValues := OrderedCollection new.
	self allRowsDo: [ :row | | dict |
		dict := Dictionary new.
		self columns withIndexDo: [ :column :idx |
			dict at: column put: (row at: idx)
		].
		mappedValues add: dict.
	].
	^ mappedValues
]

{ #category : 'accessing' }
N4CypherResult >> allRowsDo: aBlock [
	^ self
		  allDataDo: [ :dt | 
			  dt
				  at: #row
				  ifPresent: [ :row | 
				  aBlock value: row ] ]
]

{ #category : 'accessing-rows' }
N4CypherResult >> allValues [
	| values |
	values := OrderedCollection new.
	self allRowsDo: [:row | values add: row ].
	^ values
]

{ #category : 'accessing' }
N4CypherResult >> columns [
	"Answer the value of columns"

	^ columns ifNil: [columns := #()]
]

{ #category : 'accessing' }
N4CypherResult >> columns: anObject [
	"Set the value of columns"

	columns := anObject
]

{ #category : 'enumeration' }
N4CypherResult >> columnsAndDataDo: aBlock [
	| clms |
	clms := self columns.
	self data do: [:eachRow |
		1 to: clms size do: [:idx |
			aBlock value: (clms at: idx) value: (eachRow at: idx).	
		]
	]
]

{ #category : 'accessing-stats' }
N4CypherResult >> constraintsAdded [
	^self stats at: #constraints_added ifAbsent: [ 0 ]
]

{ #category : 'accessing-stats' }
N4CypherResult >> constraintsRemoved [
	^self stats at: #constraints_removed ifAbsent: [ 0 ]
]

{ #category : 'accessing-stats' }
N4CypherResult >> containsSystemUpdates [
	^self stats at: #contains_system_updates ifAbsent: [ false ]
]

{ #category : 'accessing-stats' }
N4CypherResult >> containsUpdates [
	^self stats at: #contains_updates ifAbsent: [ false ]
]

{ #category : 'accessing' }
N4CypherResult >> data [
	"Answer the value of data"

	^ data ifNil: [data := #()]
]

{ #category : 'accessing' }
N4CypherResult >> data: anObject [
	"Set the value of data"

	data := anObject
]

{ #category : 'enumeration' }
N4CypherResult >> dataDo: aBlock [
	^ self data do: aBlock
]

{ #category : 'enumeration' }
N4CypherResult >> do: aBlock [
	^ self dataDo: aBlock
]

{ #category : 'accessing' }
N4CypherResult >> firstDo: aBlock [
	^self firstDo: aBlock ifNone: []
]

{ #category : 'accessing' }
N4CypherResult >> firstDo: aBlock ifNone: noneBlock [
	^ (self firstOrNilOf: self data)
		  ifNil: noneBlock
		  ifNotNil: [ :val | aBlock value: val ]
]

{ #category : 'accessing' }
N4CypherResult >> firstGraphDo: aBlock [
	^self firstGraphDo: aBlock ifNone: []
]

{ #category : 'accessing' }
N4CypherResult >> firstGraphDo: aBlock ifNone: noneBlock [
	^ self
		  firstDo: [ :dt | 
			  dt
				  at: #graph
				  ifPresent: [ :p | 
				  aBlock value: (N4CypherGraphResult fromDictionary: p) ] ]
		  ifNone: noneBlock
]

{ #category : 'accessing' }
N4CypherResult >> firstMeta [
	^self firstDo: [ :dt | dt at: #meta ]
]

{ #category : 'private' }
N4CypherResult >> firstOrAllOf: aCollection [
	aCollection size <= 1 ifTrue: [ ^ self firstOrNilOf: aCollection ].
	^ aCollection 
]

{ #category : 'private' }
N4CypherResult >> firstOrNilOf: aCollection [
	^self portableUtil firstOrNilOf: aCollection
]

{ #category : 'accessing' }
N4CypherResult >> firstRowDo: aBlock [
	^self firstRowDo: aBlock ifNone: []
]

{ #category : 'accessing' }
N4CypherResult >> firstRowDo: aBlock ifNone: noneBlock [
	^ self
		  firstDo: [ :dt | 
			  dt
				  at: #row
				  ifPresent: [ :row | 
				  aBlock value: row ] ]
		  ifNone: noneBlock
]

{ #category : 'enumeration' }
N4CypherResult >> graphsDo: eachGraphNodesAndRelationshipsBlock [
	^ self
		dataDo: [ :eachData | 
			| graphData |
			graphData := eachData at: 'graph' ifAbsent: [].
			graphData
				ifNotNil: [ eachGraphNodesAndRelationshipsBlock value: (graphData at: 'nodes' ifAbsent: [ #() ]) value: (graphData at: 'relationships' ifAbsent: [ #() ]) ] ]
]

{ #category : 'enumeration' }
N4CypherResult >> graphsNodesDo: eachGraphNodesBlock relationshipsDo: eachGraphRelsBlock [
	^ self
		dataDo: [ :eachData | 
			| graphData |
			graphData := eachData at: 'graph' ifAbsent: [].
			graphData
				ifNotNil: [ 
					(graphData at: 'nodes' ifAbsent: [ #() ]) do: eachGraphNodesBlock.
					(graphData at: 'relationships' ifAbsent: [ #() ]) do: eachGraphRelsBlock ] ]
]

{ #category : 'accessing-stats' }
N4CypherResult >> indexesAdded [
	^self stats at: #indexes_added ifAbsent: [ 0 ]
]

{ #category : 'accessing-stats' }
N4CypherResult >> indexesRemoved [
	^self stats at: #indexes_removed ifAbsent: [ 0 ]
]

{ #category : 'accessing-stats' }
N4CypherResult >> labelsAdded [
	^self stats at: #labels_added ifAbsent: [ 0 ]
]

{ #category : 'accessing-stats' }
N4CypherResult >> labelsRemoved [
	^self stats at: #labels_removed ifAbsent: [ 0 ]
]

{ #category : 'accessing-graph' }
N4CypherResult >> nodes [
	| nodes |
	nodes := OrderedCollection new.
	self allGraphsDo: [ :graphResult |
		nodes addAll: graphResult nodes
	].
	^ nodes
]

{ #category : 'accessing-stats' }
N4CypherResult >> nodesCreated [
	^self stats at: #nodes_created ifAbsent: [ 0 ]
]

{ #category : 'accessing-stats' }
N4CypherResult >> nodesDeleted [
	^self stats at: #nodes_deleted ifAbsent: [ 0 ]
]

{ #category : 'accessing-rows' }
N4CypherResult >> oneValue [
	^ self firstRowDo: [:row | row first]
]

{ #category : 'accessing' }
N4CypherResult >> portableUtil [
	^ N4PortableUtil default
]

{ #category : 'accessing-stats' }
N4CypherResult >> propertiesSet [
	^self stats at: #properties_set ifAbsent: [ 0 ]
]

{ #category : 'accessing-stats' }
N4CypherResult >> relationshipDeleted [
	^self stats at: #relationship_deleted ifAbsent: [ 0 ]
]

{ #category : 'accessing-graph' }
N4CypherResult >> relationships [
	| relationships |
	relationships := OrderedCollection new.
	self allGraphsDo: [ :graphResult |
		relationships addAll: graphResult relationships
	].
	^ relationships
]

{ #category : 'accessing-stats' }
N4CypherResult >> relationshipsCreated [
	^self stats at: #relationships_created ifAbsent: [ 0 ]
]

{ #category : 'accessing-stats' }
N4CypherResult >> relationshipsDeleted [
	^self stats at: #relationships_deleted ifAbsent: [ 0 ]
]

{ #category : 'accessing-rows' }
N4CypherResult >> rows [
	| rows |
	rows := OrderedCollection new.
	self allRowsDo: [ :row | rows add: row ].
	^rows
]

{ #category : 'accessing' }
N4CypherResult >> stats [

	^ stats ifNil: [ stats := Dictionary new ]
]

{ #category : 'accessing' }
N4CypherResult >> stats: anObject [

	stats := anObject
]

{ #category : 'accessing-stats' }
N4CypherResult >> systemUpdates [
	^self stats at: #system_updates ifAbsent: [ 0 ]
]

{ #category : 'accessing-rows' }
N4CypherResult >> values [
	| values |
	values := OrderedCollection new.
	self allRowsDo: [:row | values add: (self firstOrAllOf: row)].
	^ self firstOrAllOf: values
]
