actions-multiple-cypher
queryByCyphersWithParams: queryWithParams
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