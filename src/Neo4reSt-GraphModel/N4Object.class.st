Class {
	#name : 'N4Object',
	#superclass : 'Object',
	#instVars : [
		'settings',
		'httpClient'
	],
	#category : 'Neo4reSt-GraphModel',
	#package : 'Neo4reSt-GraphModel'
}

{ #category : 'instance creation' }
N4Object class >> db: aGraphDb [
	| inst |
	inst := self new.
	inst db: aGraphDb.
	^inst
]

{ #category : 'instance creation' }
N4Object class >> from: response [
	^self id: (self portableUtil pickIdFrom: response location).
	
]

{ #category : 'instance creation' }
N4Object class >> id: anInteger [ 
	| inst |
	inst := self new.
	inst id: anInteger asInteger.
	^inst
]

{ #category : 'instance creation' }
N4Object class >> json: jsonObject [
	^self new
	
]

{ #category : 'accessing' }
N4Object class >> portableUtil [
	^N4PortableUtil default
]

{ #category : 'factory' }
N4Object >> createSettings [
	^ N4Settings default
]

{ #category : 'accessing' }
N4Object >> httpClient [

	^ httpClient ifNil: [httpClient := N4HttpClient settings: self settings]
]

{ #category : 'accessing' }
N4Object >> httpClient: anObject [
	"Set the value of restClient"

	httpClient := anObject
]

{ #category : 'factory' }
N4Object >> nodeClass [
	^N4Node
]

{ #category : 'accessing' }
N4Object >> portableUtil [
	^self class portableUtil
]

{ #category : 'printing' }
N4Object >> printElementHeaderOn: aStream [
	aStream nextPutAll: self className
	
]

{ #category : 'printing' }
N4Object >> printOn: aStream [
	self printElementHeaderOn: aStream
]

{ #category : 'factory' }
N4Object >> relationshipClass [
	^N4Relationship
]

{ #category : 'accessing' }
N4Object >> settings [
	"Answer the value of settings"

	^ settings ifNil: [settings := self createSettings]
]

{ #category : 'accessing' }
N4Object >> settings: anObject [
	"Set the value of settings"

	settings := anObject
]
