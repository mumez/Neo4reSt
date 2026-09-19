Class {
	#name : 'N4HttpClient',
	#superclass : 'Object',
	#instVars : [
		'rawClient',
		'settings',
		'logger'
	],
	#category : 'Neo4reSt-Client',
	#package : 'Neo4reSt-Client'
}

{ #category : 'instance creation' }
N4HttpClient class >> rootUri: rootUri [
	^ self new rootUri: rootUri; yourself
]

{ #category : 'instance creation' }
N4HttpClient class >> settings: aN4Settings [
	| inst |
	inst := self new.
	inst applySettings: aN4Settings.
	^inst
]

{ #category : 'initialization' }
N4HttpClient >> applySettings: aNgSettings [
	self settings: aNgSettings.
	self rawClient applySettings: aNgSettings.
]

{ #category : 'releasing' }
N4HttpClient >> close [
	self rawClient ifNotNil: [:cli | cli release]
	
]

{ #category : 'accessing' }
N4HttpClient >> getBasicInformation [
	^ self rawClient getBasicInformation
]

{ #category : 'actions-cypher' }
N4HttpClient >> graphCypher: cypherQuery [
	^self graphCypher: cypherQuery params: nil stats: nil
]

{ #category : 'actions-cypher' }
N4HttpClient >> graphCypher: cypherQuery params: params [
	^self graphCypher: cypherQuery params: params stats: nil
]

{ #category : 'actions-cypher' }
N4HttpClient >> graphCypher: cypherQuery params: params stats: aBoolean [
	^self runCypher: cypherQuery params: params format: #graph stats: aBoolean
]

{ #category : 'logging' }
N4HttpClient >> logInfo: anObject tag: tag [
	self logger ifNotNil: [:lgr | lgr value: {#info. tag. anObject}]
]

{ #category : 'accessing' }
N4HttpClient >> logger [

	^ logger
]

{ #category : 'accessing' }
N4HttpClient >> logger: anObject [

	logger := anObject
]

{ #category : 'builder' }
N4HttpClient >> newCypher: queryString params: dictionary [
	^self newCypher: queryString params: dictionary resultDataContents: nil includeStats: nil
]

{ #category : 'builder' }
N4HttpClient >> newCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean [
	^self rawClient newTransactionStatementJson: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean
]

{ #category : 'accessing' }
N4HttpClient >> portableUtil [
	^self rawClient portableUtil
]

{ #category : 'actions-basic-cypher' }
N4HttpClient >> queryByCypher: queryString [
	self logInfo: queryString tag: #queryByCypher:.
	^self queryByCypher: queryString params: nil resultDataContents: nil includeStats: nil
]

{ #category : 'actions-basic-cypher' }
N4HttpClient >> queryByCypher: queryString params: dictionary [
	self logInfo: {queryString. dictionary} tag: #queryByCypher:params:.
	^self queryByCypher: queryString params: dictionary resultDataContents: nil includeStats: nil
]

{ #category : 'actions-basic-cypher' }
N4HttpClient >> queryByCypher: queryString params: dictionary resultDataContents: resultDataContents [
	^self queryByCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: nil
]

{ #category : 'actions-basic-cypher' }
N4HttpClient >> queryByCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean [
	| resp |
	resp := self rawClient queryByCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean.
	^N4CypherResponse json: (self portableUtil readJsonFromResponse: resp)
]

{ #category : 'actions-multiple-cypher' }
N4HttpClient >> queryByCyphers: queryStrings [
	^ self queryByCyphersWithParams: queryStrings
]

{ #category : 'actions-multiple-cypher' }
N4HttpClient >> queryByCyphers: queryStrings arrayOfParams: arrayOfParams [
	self logInfo: {queryStrings. arrayOfParams} tag: #queryByCyphers:arrayOfParams:.
	^self queryByCyphersUsing: [:statements :builder |
		queryStrings with: arrayOfParams do: [ :queryString :params | 
			statements add: (self newCypher: queryString params: params).
		]
		statements
	]
]

{ #category : 'actions-multiple-cypher' }
N4HttpClient >> queryByCyphersUsing: queryBuildingBlock [
	| resp |
	resp := self rawClient queryByCyphersUsing: queryBuildingBlock.
	^N4CypherResponse json: (self portableUtil readJsonFromResponse: resp)
]

{ #category : 'actions-multiple-cypher' }
N4HttpClient >> queryByCyphersWithParams: queryWithParams [
	self logInfo: queryWithParams tag: #queryByCyphersWithParams:.
	^self queryByCyphersUsing: [:statements :builder |
		queryWithParams do: [ :queryParamPair | 
			queryParamPair isString ifTrue: [  
				statements add: (self newCypher: queryParamPair params: #()).
			] ifFalse: [  
				statements add: (self newCypher: queryParamPair first params: queryParamPair second asDictionary).
			]
		].
		statements
	]
]

{ #category : 'accessing' }
N4HttpClient >> rawClient [

	^ rawClient ifNil: [rawClient := N4RawClient new]
]

{ #category : 'accessing' }
N4HttpClient >> rawClient: anObject [
	"Set the value of rawClient"

	rawClient := anObject
]

{ #category : 'accessing' }
N4HttpClient >> rootUri [
	^ self rawClient rootUri
]

{ #category : 'accessing' }
N4HttpClient >> rootUri: uriString [
	self rawClient rootUri: uriString
]

{ #category : 'actions-cypher' }
N4HttpClient >> runCypher: cypherQuery [
	^self runCypher: cypherQuery stats: nil
]

{ #category : 'actions-cypher' }
N4HttpClient >> runCypher: cypherQuery params: params [
	^self runCypher: cypherQuery params: params format: nil stats: nil
]

{ #category : 'actions-cypher' }
N4HttpClient >> runCypher: cypherQuery params: params format: graphOrRow stats: aBoolean [
	| resultDataContents resp |
	resultDataContents := nil.
	graphOrRow == #row ifTrue: [ resultDataContents := #(row) ].
	graphOrRow == #graph ifTrue: [ resultDataContents := #(graph) ].
	self logInfo: {cypherQuery. params. graphOrRow. aBoolean} tag: #runCypher:params:format:stats:.
	resp := self queryByCypher: cypherQuery cypherString params: params resultDataContents: resultDataContents includeStats: aBoolean.
	resp signalIfError.
	^resp
]

{ #category : 'actions-cypher' }
N4HttpClient >> runCypher: cypherQuery stats: aBoolean [
	^self runCypher: cypherQuery params: nil format: nil stats: aBoolean
]

{ #category : 'accessing' }
N4HttpClient >> settings [
	settings ifNil: [ settings := N4Settings default ].
	^ settings
]

{ #category : 'accessing' }
N4HttpClient >> settings: anObject [

	settings := anObject
]

{ #category : 'logging' }
N4HttpClient >> startLoggingToTranscript [
	self logger: [ :loggedTuple | Transcript crShow: {#N4GraphDb. loggedTuple} ]
]

{ #category : 'actions-cypher' }
N4HttpClient >> statsCypher: cypherQuery [
	^self runCypher: cypherQuery stats: true
]

{ #category : 'actions-cypher' }
N4HttpClient >> statsCypher: cypherQuery params: params [
	^self runCypher: cypherQuery params: params format: nil stats: true
]

{ #category : 'logging' }
N4HttpClient >> stopLogging [
	logger := nil
]
