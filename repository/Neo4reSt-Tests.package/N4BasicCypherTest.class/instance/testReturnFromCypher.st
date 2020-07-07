testing
testReturnFromCypher
	| cypher resp |
	cypher := 'WITH 123 as A RETURN A'.
	resp := N4GraphDb new queryByCypher: cypher.
	self assert: resp hasErrors not.
	self assert: (resp result data first at: 'row') = #(123)