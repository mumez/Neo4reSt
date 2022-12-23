actions-query
queryByCypher: queryString params: dictionary
	^self queryByCypher: queryString params: dictionary resultDataContents: nil includeStats: nil