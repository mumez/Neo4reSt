Class {
	#name : 'N4Error',
	#superclass : 'Error',
	#instVars : [
		'properties',
		'response'
	],
	#category : 'Neo4reSt-Core',
	#package : 'Neo4reSt-Core'
}

{ #category : 'instance creation' }
N4Error class >> properties: assocs [
	^self new properties: assocs
]

{ #category : 'instance creation' }
N4Error class >> response: response [
	^self new response: response
]

{ #category : 'accessing' }
N4Error >> properties [
	"Answer the value of properties"

	^ properties
]

{ #category : 'accessing' }
N4Error >> properties: anObject [
	"Set the value of properties"

	properties := anObject
]

{ #category : 'accessing' }
N4Error >> response [
	"Answer the value of response"

	^ response
]

{ #category : 'accessing' }
N4Error >> response: anObject [
	"Set the value of response"

	response := anObject
]
