Class {
	#name : 'N4Indexes',
	#superclass : 'Object',
	#instVars : [
		'name',
		'indexer'
	],
	#category : 'Neo4reSt-IndexModel',
	#package : 'Neo4reSt-IndexModel'
}

{ #category : 'instance creation' }
N4Indexes class >> on: indexer [
	^ self new indexer: indexer; yourself
]

{ #category : 'instance creation' }
N4Indexes class >> on: indexer named: indexName [
	^ self new indexer: indexer; name: indexName; yourself
]

{ #category : 'actions' }
N4Indexes >> addKey: key value: value for: graphEntry [
	
]

{ #category : 'accessing' }
N4Indexes >> db [
	^self indexer db
]

{ #category : 'actions' }
N4Indexes >> delete [
]

{ #category : 'actions' }
N4Indexes >> detectWith: keyValueAssoc [
	^self detectWithKey: keyValueAssoc key value: keyValueAssoc value
]

{ #category : 'actions' }
N4Indexes >> detectWithKey: key value: value [
]

{ #category : 'accessing' }
N4Indexes >> httpClient [
	^self indexer httpClient
]

{ #category : 'accessing' }
N4Indexes >> indexer [
	"Answer the value of indexer"

	^ indexer
]

{ #category : 'accessing' }
N4Indexes >> indexer: anObject [
	"Set the value of indexer"

	indexer := anObject
]

{ #category : 'accessing' }
N4Indexes >> name [
	^name
]

{ #category : 'accessing' }
N4Indexes >> name: anObject [
	"Set the value of name"

	name := anObject
]

{ #category : 'actions' }
N4Indexes >> removeAllFor: graphObject [
]

{ #category : 'actions' }
N4Indexes >> removeAllKeyed: key for: graphEntry [
	^self httpClient removeNodeIndexes: self name from: key key: graphEntry id
]

{ #category : 'actions' }
N4Indexes >> removeAllKeyed: key value: value for: graphEntry [
	
]
