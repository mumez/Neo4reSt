private-cypher
runCypherResultsWrapped: cypherQuery
	| resp |
	resp := self runCypher: cypherQuery.
	^resp results