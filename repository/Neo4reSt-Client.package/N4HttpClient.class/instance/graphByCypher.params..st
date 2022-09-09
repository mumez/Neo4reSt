actions-query
graphByCypher: queryString params: dictionary
	^self queryByCypher: queryString params: dictionary resultDataContents: #('graph') includeStats: nil