Class {
	#name : 'N4Settings',
	#superclass : 'Object',
	#instVars : [
		'settingsDict'
	],
	#classInstVars : [
		'default'
	],
	#category : 'Neo4reSt-Core',
	#package : 'Neo4reSt-Core'
}

{ #category : 'instance creation' }
N4Settings class >> default [
	default ifNil: [default := self new].
	^default
]

{ #category : 'class initialization' }
N4Settings class >> initialize [
	default := nil
]

{ #category : 'actions-dictionary' }
N4Settings >> at: key [
	^self settingsDict at: key
]

{ #category : 'actions-dictionary' }
N4Settings >> at: key ifAbsent: aBlock [
	^self settingsDict at: key ifAbsent: aBlock
]

{ #category : 'actions-dictionary' }
N4Settings >> at: key ifAbsentPut: aBlock [
	^self settingsDict at: key ifAbsentPut: aBlock
]

{ #category : 'actions-dictionary' }
N4Settings >> at: key put: value [
	^self settingsDict at: key put: value
]

{ #category : 'accessing' }
N4Settings >> databaseName [
	^ self at: #databaseName ifAbsentPut: ['neo4j']
]

{ #category : 'accessing' }
N4Settings >> databaseName: aString [
	^self at: #databaseName put: aString
]

{ #category : 'defaults' }
N4Settings >> defaultRootUri [
	self supportV4 ifTrue: [ ^'http://localhost:7474/' ].
	^'http://localhost:7474/db/data/'
]

{ #category : 'actions-dictionary' }
N4Settings >> includesKey: key [
	^self settingsDict includesKey: key
]

{ #category : 'initialization' }
N4Settings >> initialize [
	settingsDict := nil
]

{ #category : 'accessing' }
N4Settings >> keepConnection [
	^self at: #keepConnection ifAbsentPut: [true]
]

{ #category : 'accessing' }
N4Settings >> keepConnection: aBoolean [
	^self at: #keepConnection put: aBoolean == true
]

{ #category : 'actions-dictionary' }
N4Settings >> keys [
	^self settingsDict keys
]

{ #category : 'authentication' }
N4Settings >> password [
	^self at: #password ifAbsentPut: ['neo4j']
]

{ #category : 'authentication' }
N4Settings >> password: aString [
	self at: #password put: aString
]

{ #category : 'accessing' }
N4Settings >> rootUri [
	^ self at: #rootUri ifAbsent: [self defaultRootUri]
]

{ #category : 'accessing' }
N4Settings >> rootUri:  aString [
	^self at: #rootUri put: aString
]

{ #category : 'accessing-private' }
N4Settings >> settingsDict [
	^ settingsDict ifNil: [settingsDict := IdentityDictionary new]
]

{ #category : 'accessing' }
N4Settings >> supportV4 [
	^self at: #supportV4 ifAbsentPut: [true]
]

{ #category : 'accessing' }
N4Settings >> supportV4: aBoolean [
	self at: #supportV4 put: aBoolean
]

{ #category : 'authentication' }
N4Settings >> useAuthentication [
	^self at: #authentication ifAbsentPut: [true] "From Neo4j 2.0 - true by default"
]

{ #category : 'authentication' }
N4Settings >> useAuthentication: aBoolean [
	self at: #authentication put: aBoolean
]

{ #category : 'accessing' }
N4Settings >> useStreaming [
	^self at: #useStreaming ifAbsentPut: [true]
]

{ #category : 'accessing' }
N4Settings >> useStreaming: aBoolean [
	self at: #useStreaming put: aBoolean
]

{ #category : 'authentication' }
N4Settings >> username [
	^self at: #username ifAbsentPut: ['neo4j']
]

{ #category : 'authentication' }
N4Settings >> username: aString [
	self at: #username put: aString
]
