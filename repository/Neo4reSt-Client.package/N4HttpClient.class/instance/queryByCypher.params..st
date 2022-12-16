actions-basic-cypher
queryByCypher: queryString params: dictionary
	self logInfo: {queryString. dictionary} tag: #queryByCypher:params:.
	^self queryByCypher: queryString params: dictionary resultDataContents: nil includeStats: nil