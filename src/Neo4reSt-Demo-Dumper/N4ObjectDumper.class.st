Class {
	#name : 'N4ObjectDumper',
	#superclass : 'Object',
	#instVars : [
		'db',
		'count'
	],
	#category : 'Neo4reSt-Demo-Dumper',
	#package : 'Neo4reSt-Demo-Dumper'
}

{ #category : 'actions' }
N4ObjectDumper class >> dump: anObject [
	| inst |
	inst := self on: N4GraphDb new.
	inst dump: anObject.	
	^inst
]

{ #category : 'examples' }
N4ObjectDumper class >> example1 [
	"N4ObjectDumper example1"
	| snapshot workingCopy |
	workingCopy := MCWorkingCopy allManagers detect: [:each | each package name = 'Neo4reSt'].
	snapshot := workingCopy package snapshot.
	N4ObjectDumper dump: snapshot.
]

{ #category : 'instance creation' }
N4ObjectDumper class >> on: aGraphDb [
	^ self new db: aGraphDb; yourself
]

{ #category : 'private' }
N4ObjectDumper >> checkTooManyRecursion [
	self count: (self count + 1).
	self count >= 1000000 ifTrue: [self halt]
]

{ #category : 'accessing' }
N4ObjectDumper >> count [
	"Answer the value of count"

	^ count ifNil: [count := 0]
]

{ #category : 'accessing' }
N4ObjectDumper >> count: anObject [
	"Set the value of count"

	count := anObject
]

{ #category : 'accessing' }
N4ObjectDumper >> db [
	"Answer the value of db"

	^ db
]

{ #category : 'accessing' }
N4ObjectDumper >> db: anObject [
	"Set the value of db"

	db := anObject
]

{ #category : 'dumping' }
N4ObjectDumper >> dump: startObject [ 
	| newNode |
	newNode := self db createNode.
	self labelStartNode: newNode.
	self dumpObject: startObject to: newNode
	

]

{ #category : 'private-dumping' }
N4ObjectDumper >> dumpClassInfo: anObject to: aNode [
	aNode at: '_className' put: anObject class name asString. 
	aNode at: '_superclassName' put: anObject class superclass name. 
]

{ #category : 'private-dumping' }
N4ObjectDumper >> dumpNextObject: nextObj named: eachName to: aNode [ 
	| newNode |
	newNode := self db createNode.
	aNode relateTo: newNode type: eachName.
	self dumpObject: nextObj to: newNode
]

{ #category : 'private-dumping' }
N4ObjectDumper >> dumpObject: anObject to: aNode [ 
	self checkTooManyRecursion.
	self dumpClassInfo: anObject to: aNode.
	anObject class allInstVarNames
		do: [:eachName | 
			| childObj |
			childObj := anObject instVarNamed: eachName.
			(self shouldDumpAsProperty: childObj)
				ifTrue: [self dumpProperty: childObj named: eachName to: aNode]
				ifFalse: [self dumpNextObject: childObj named: eachName to: aNode]].
	anObject class isVariable
		ifTrue: [anObject
				keysAndValuesDo: [:key :value | 
					self dumpNextObject: value named: key to: aNode]]
]

{ #category : 'private-dumping' }
N4ObjectDumper >> dumpProperty: propValue named: propName to: aNode [
	[ aNode at: propName put: propValue ] on: Error do: [:ex |
		[ aNode at: propName put: propValue toStomp "last resort - write as StOMP bytes"	] on: MessageNotUnderstood do: [:e |
			self error: 'This demo requires StOMP'
		]
	]
]

{ #category : 'private' }
N4ObjectDumper >> labelStartNode: startNode [
	| timestampKey |
	timestampKey := DateAndTime now printString.
	db initialNode relateTo: startNode type: timestampKey
]

{ #category : 'testing' }
N4ObjectDumper >> shouldDumpAsProperty: anObject [
	anObject isString ifTrue: [^true].
	anObject isNumber ifTrue: [^true].
	anObject isNil ifTrue: [^true].
	anObject == true ifTrue: [^true].
	anObject == false ifTrue: [^true].
	
	^false
	
]
