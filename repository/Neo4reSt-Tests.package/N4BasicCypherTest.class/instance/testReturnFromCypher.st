testing
testReturnFromCypher
	self dbDo: [ :db | 
		| cypher resp |
		cypher := 'WITH 123 as A RETURN A'.
		resp := db runCypher: cypher.
		self assert: resp hasErrors not.
		self assert: resp oneValue equals: 123.
	].