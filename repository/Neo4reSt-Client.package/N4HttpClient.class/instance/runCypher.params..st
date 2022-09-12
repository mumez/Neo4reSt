private-cypher
runCypher: cypherQuery params: params
	^self runCypher: cypherQuery params: params format: nil stats: nil