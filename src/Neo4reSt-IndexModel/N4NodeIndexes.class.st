Class {
	#name : 'N4NodeIndexes',
	#superclass : 'N4Indexes',
	#category : 'Neo4reSt-IndexModel',
	#package : 'Neo4reSt-IndexModel'
}

{ #category : 'actions' }
N4NodeIndexes >> addKey: key value: value for: graphEntry [
	^self httpClient addNodeIndex: self name on: graphEntry uri key: key value: value
]

{ #category : 'actions' }
N4NodeIndexes >> delete [
	^ self httpClient deleteNodeIndexes: self name
]

{ #category : 'actions' }
N4NodeIndexes >> detectWithKey: key value: value [
	| jsons |
	jsons := self httpClient getNodeWithIndex: self name key: key value: value.
	jsons isEmpty ifTrue: [^nil].
	^ (self db nodeClass json: jsons first) db: self db
]

{ #category : 'actions' }
N4NodeIndexes >> removeAllFor: graphObject [
	^self httpClient removeNodeIndexes: self name on: graphObject id
]

{ #category : 'actions' }
N4NodeIndexes >> removeAllKeyed: key for: graphEntry [
	^self httpClient removeNodeIndexes: self name from: key key: graphEntry id
]

{ #category : 'actions' }
N4NodeIndexes >> removeAllKeyed: key value: value for: graphEntry [
	^self httpClient removeNodeIndexes: self name from: graphEntry id key: key value: value
]
