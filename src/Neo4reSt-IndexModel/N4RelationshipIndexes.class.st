Class {
	#name : 'N4RelationshipIndexes',
	#superclass : 'N4Indexes',
	#category : 'Neo4reSt-IndexModel',
	#package : 'Neo4reSt-IndexModel'
}

{ #category : 'actions' }
N4RelationshipIndexes >> addKey: key value: value for: graphEntry [
	^self httpClient addRelationshipIndex: self name on: graphEntry uri key: key value: value
]

{ #category : 'actions' }
N4RelationshipIndexes >> delete [
	^ self httpClient deleteRelationshipIndexes: self name
]

{ #category : 'actions' }
N4RelationshipIndexes >> detectWithKey: key value: value [
	| jsons |
	jsons := self httpClient getRelationshipWithIndex: self name key: key value: value.
	jsons isEmpty ifTrue: [ ^ nil ].
	^ (self db relationshipClass json: jsons first) db: self db
]

{ #category : 'actions' }
N4RelationshipIndexes >> removeAllFor: graphEntry [
	^self httpClient removeRelationshipIndexes: self name on: graphEntry id
]

{ #category : 'actions' }
N4RelationshipIndexes >> removeAllKeyed: key for: graphEntry [
	^self httpClient removeRelationshipIndexes: self name from: key key: graphEntry id
]

{ #category : 'actions' }
N4RelationshipIndexes >> removeAllKeyed: key value: value for: graphEntry [
	^self httpClient removeRelationshipIndexes: self name from: graphEntry id key: key value: value
]
