Class {
	#name : 'N4GraphObject',
	#superclass : 'N4Object',
	#instVars : [
		'db',
		'id',
		'rawGraphObject'
	],
	#category : 'Neo4reSt-GraphModel',
	#package : 'Neo4reSt-GraphModel'
}

{ #category : 'instance creation' }
N4GraphObject class >> db: aGraphDb [
	| inst |
	inst := self new.
	inst db: aGraphDb.
	^inst
]

{ #category : 'instance creation' }
N4GraphObject class >> from: response [
	^self id: (self portableUtil pickIdFrom: response location).
	
]

{ #category : 'instance creation' }
N4GraphObject class >> id: anInteger [ 
	| inst |
	inst := self new.
	inst id: anInteger asInteger.
	^inst
]

{ #category : 'instance creation' }
N4GraphObject class >> json: jsonObject [
	^self new
	
]

{ #category : 'instance creation' }
N4GraphObject class >> on: rawGraphObject from: database [
	^self new
		rawGraphObject: rawGraphObject;
		initWithDb: database;
		yourself
]

{ #category : 'accessing' }
N4GraphObject class >> portableUtil [
	^N4PortableUtil default
]

{ #category : 'comparing' }
N4GraphObject >> = other [
	^ self class = other class and: [self id = other id]
]

{ #category : 'accessing' }
N4GraphObject >> @ propName [
	^self propertyAt: propName
]

{ #category : 'properties' }
N4GraphObject >> at: propName [ 
	"shortcut"
	^self propertyAt: propName
]

{ #category : 'properties' }
N4GraphObject >> at: propName put: value [
	"shortcut"
	^self propertyAt: propName put: value
]

{ #category : 'accessing' }
N4GraphObject >> db [
	"Answer the value of db"

	^ db
]

{ #category : 'accessing' }
N4GraphObject >> db: anObject [
	"Set the value of db"

	db := anObject
]

{ #category : 'deleting' }
N4GraphObject >> delete [
	
]

{ #category : 'printing' }
N4GraphObject >> elementName [
	^self class name
]

{ #category : 'comparing' }
N4GraphObject >> hash [
	^self id hash
]

{ #category : 'accessing' }
N4GraphObject >> id [
	"Answer the value of id"

	^ id
]

{ #category : 'accessing' }
N4GraphObject >> id: anObject [
	"Set the value of id"

	id := anObject
]

{ #category : 'initialization' }
N4GraphObject >> initWithDb: aDatabase [
	db := aDatabase.
	settings := db settings.
	id := rawGraphObject id
]

{ #category : 'accessing' }
N4GraphObject >> name [
	^ self propertyAt: 'name' 
]

{ #category : 'accessing' }
N4GraphObject >> name: aString [
	self propertyAt: 'name' put: aString 
]

{ #category : 'printing' }
N4GraphObject >> printElementHeaderOn: aStream [
	aStream nextPutAll: self elementName.
	aStream nextPut: $[.
	aStream nextPutAll: self id printString.
	aStream nextPut: $]
	
]

{ #category : 'printing' }
N4GraphObject >> printOn: aStream [
	self printElementHeaderOn: aStream
]

{ #category : 'properties' }
N4GraphObject >> properties [
	^self rawGraphObject properties
]

{ #category : 'properties' }
N4GraphObject >> properties: propAssocs [
]

{ #category : 'properties' }
N4GraphObject >> propertyAt: propName [
	^self rawGraphObject propertyAt: propName
]

{ #category : 'properties' }
N4GraphObject >> propertyAt: propName put: value [
]

{ #category : 'accessing' }
N4GraphObject >> rawGraphObject [
	^ rawGraphObject
]

{ #category : 'accessing' }
N4GraphObject >> rawGraphObject: anObject [
	rawGraphObject := anObject
]

{ #category : 'loading' }
N4GraphObject >> reload [
	| newGraphObject |
	newGraphObject := self db nodeAt: self id.
	self rawGraphObject: newGraphObject.
]

{ #category : 'properties' }
N4GraphObject >> removePropertyAt: propName [
]
