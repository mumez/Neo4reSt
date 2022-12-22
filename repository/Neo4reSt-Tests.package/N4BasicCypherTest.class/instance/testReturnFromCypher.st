testing
testReturnFromCypher
	self dbDo: [ :db | 
		| cypher resp |
		cypher := 'WITH 123 as A RETURN A'.
		resp := db queryByCypher: cypher.
		self assert: resp hasErrors not.
		self assert: (resp result data first at: 'row') equals: #(123).
	].