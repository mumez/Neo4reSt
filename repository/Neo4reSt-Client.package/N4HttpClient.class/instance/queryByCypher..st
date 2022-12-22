actions-basic-cypher
queryByCypher: queryString
	self logInfo: queryString tag: #queryByCypher:.
	^self queryByCypher: queryString params: nil resultDataContents: nil includeStats: nil