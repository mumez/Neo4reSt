Class {
	#name : 'N4CypherResponse',
	#superclass : 'Object',
	#instVars : [
		'commit',
		'results',
		'transaction',
		'errors'
	],
	#category : 'Neo4reSt-Cypher',
	#package : 'Neo4reSt-Cypher'
}

{ #category : 'instance creation' }
N4CypherResponse class >> json: jsonObject [
	| inst |
	inst := self new.
	inst commit: (jsonObject at: 'commit' ifAbsent:[]).
	inst results: ((jsonObject at: 'results' ifAbsent:[#()]) collect: [:each | N4CypherResult json: each]).
	inst transaction: (jsonObject at: 'transaction' ifAbsent:[]).
	inst errors: (jsonObject at: 'errors' ifAbsent:[]).
	^inst
]

{ #category : 'accessing-results' }
N4CypherResponse >> allMappedValues [
	^self resultsDo: [:result | result allMappedValues]
]

{ #category : 'accessing-results' }
N4CypherResponse >> allOneValues [
	^self resultsDo: [:result | result oneValue]
]

{ #category : 'accessing-results' }
N4CypherResponse >> allValues [
	^self resultsDo: [:result | result allValues]
]

{ #category : 'accessing' }
N4CypherResponse >> commit [
	^ commit
]

{ #category : 'accessing' }
N4CypherResponse >> commit: anObject [
	commit := anObject
]

{ #category : 'accessing' }
N4CypherResponse >> error [
	self errors isEmptyOrNil ifTrue: [^nil].
	^ self errors at: 1
]

{ #category : 'accessing' }
N4CypherResponse >> errors [
	^ errors
]

{ #category : 'accessing' }
N4CypherResponse >> errors: anObject [
	errors := anObject
]

{ #category : 'testing' }
N4CypherResponse >> hasErrors [
	^self errors notNil and: [self errors notEmpty]
]

{ #category : 'accessing-results' }
N4CypherResponse >> oneValue [
	^self resultDo: [:result | result oneValue]
]

{ #category : 'accessing-results' }
N4CypherResponse >> oneValues [
	^self resultDo: [:result | result values]
]

{ #category : 'accessing' }
N4CypherResponse >> result [
	self results isEmptyOrNil ifTrue: [^nil].
	^ self results at: 1
]

{ #category : 'actions' }
N4CypherResponse >> resultDo: aBlock [
	self signalIfError.
	^ aBlock value: self result
]

{ #category : 'accessing' }
N4CypherResponse >> results [
	^ results
]

{ #category : 'accessing' }
N4CypherResponse >> results: anObject [
	results := anObject
]

{ #category : 'actions' }
N4CypherResponse >> resultsDo: aBlock [
	self signalIfError.
	^ self results collect: aBlock
]

{ #category : 'actions' }
N4CypherResponse >> signalIfError [
	self hasErrors ifTrue: [ (N4CypherError response: self) signal].
]

{ #category : 'accessing' }
N4CypherResponse >> transaction [
	^ transaction
]

{ #category : 'accessing' }
N4CypherResponse >> transaction: anObject [
	transaction := anObject
]

{ #category : 'accessing-results' }
N4CypherResponse >> values [
	self results size > 1 ifTrue: [ 
		^ self resultsDo: [ :result | result values ] ].
	^ self resultDo: [ :result | result values ]
]
