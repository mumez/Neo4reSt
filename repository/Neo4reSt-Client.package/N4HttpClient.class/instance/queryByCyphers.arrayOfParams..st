actions-multiple-cypher
queryByCyphers: queryStrings arrayOfParams: arrayOfParams
	^self queryByCyphersUsing: [:statements :builder |
		queryStrings with: arrayOfParams do: [ :queryString :params | 
			statements add: (self newCypher: queryString params: params).
		]
		statements
	]