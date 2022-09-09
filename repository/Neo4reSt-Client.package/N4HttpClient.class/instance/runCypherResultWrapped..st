private-cypher
runCypherResultWrapped: cypherQuery
	| resp |
	resp := self runCypher: cypherQuery.
	^resp result