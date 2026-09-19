Class {
	#name : 'N4Indexer',
	#superclass : 'Object',
	#instVars : [
		'db'
	],
	#category : 'Neo4reSt-IndexModel',
	#package : 'Neo4reSt-IndexModel'
}

{ #category : 'instance creation' }
N4Indexer class >> on: graphDb [
	^ self new db: graphDb; yourself
]

{ #category : 'accessing' }
N4Indexer >> db [
	"Answer the value of db"

	^ db
]

{ #category : 'accessing' }
N4Indexer >> db: anObject [
	"Set the value of db"

	db := anObject
]

{ #category : 'accessing' }
N4Indexer >> httpClient [
	^self db httpClient
]

{ #category : 'actions' }
N4Indexer >> nodeIndexesNamed: indexName [
	^ N4NodeIndexes on: self named: indexName
]

{ #category : 'actions' }
N4Indexer >> relationshipIndexesNamed: indexName [
	^ N4RelationshipIndexes on: self named: indexName
]
