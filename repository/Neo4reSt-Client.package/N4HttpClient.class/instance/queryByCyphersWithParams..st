actions-multiple-cypher
queryByCyphersWithParams: queryWithParams
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