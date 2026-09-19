Class {
	#name : 'N4LegacyCypherErrorReport',
	#superclass : 'N4LegacyCypherResponse',
	#instVars : [
		'message',
		'exception',
		'stackTrace'
	],
	#category : 'Neo4reSt-Cypher',
	#package : 'Neo4reSt-Cypher'
}

{ #category : 'instance creation' }
N4LegacyCypherErrorReport class >> json: jsonObject [
	| inst |
	inst := self new.
	inst message: (jsonObject at: 'message').
	inst exception: (jsonObject at: 'exception').
	inst stackTrace: (jsonObject at: 'stackTrace').
	^inst
]

{ #category : 'accessing' }
N4LegacyCypherErrorReport >> exception [
	"Answer the value of exception"

	^ exception
]

{ #category : 'accessing' }
N4LegacyCypherErrorReport >> exception: anObject [
	"Set the value of exception"

	exception := anObject
]

{ #category : 'accessing' }
N4LegacyCypherErrorReport >> message [
	"Answer the value of message"

	^ message
]

{ #category : 'accessing' }
N4LegacyCypherErrorReport >> message: anObject [
	"Set the value of message"

	message := anObject
]

{ #category : 'accessing' }
N4LegacyCypherErrorReport >> stackTrace [
	"Answer the value of stackTrace"

	^ stackTrace
]

{ #category : 'accessing' }
N4LegacyCypherErrorReport >> stackTrace: anObject [
	"Set the value of stackTrace"

	stackTrace := anObject
]
