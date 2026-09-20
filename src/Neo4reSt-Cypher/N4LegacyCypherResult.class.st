Class {
	#name : 'N4LegacyCypherResult',
	#superclass : 'Object',
	#instVars : [
		'columns',
		'data'
	],
	#category : 'Neo4reSt-Cypher',
	#package : 'Neo4reSt-Cypher'
}

{ #category : 'instance creation' }
N4LegacyCypherResult class >> json: jsonObject [
	| inst |
	inst := self new.
	inst columns: (jsonObject at: 'columns' ifAbsent:[]).
	inst data: (jsonObject at: 'data' ifAbsent:[]).
	^inst
]

{ #category : 'accessing' }
N4LegacyCypherResult >> columns [
	"Answer the value of columns"

	^ columns ifNil: [columns := #()]
]

{ #category : 'accessing' }
N4LegacyCypherResult >> columns: anObject [
	"Set the value of columns"

	columns := anObject
]

{ #category : 'enumeration' }
N4LegacyCypherResult >> columnsAndDataDo: aBlock [
	| clms |
	clms := self columns.
	self data do: [:eachRow |
		1 to: clms size do: [:idx |
			aBlock value: (clms at: idx) value: (eachRow at: idx).	
		]
	]
]

{ #category : 'accessing' }
N4LegacyCypherResult >> data [
	"Answer the value of data"

	^ data ifNil: [data := #()]
]

{ #category : 'accessing' }
N4LegacyCypherResult >> data: anObject [
	"Set the value of data"

	data := anObject
]

{ #category : 'enumeration' }
N4LegacyCypherResult >> dataDo: aBlock [
	^ self data do: aBlock
]

{ #category : 'enumeration' }
N4LegacyCypherResult >> do: aBlock [
	^ self dataDo: aBlock
]
