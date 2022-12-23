actions-cypher
statsCypher: cypherQuery params: params
	^self runCypher: cypherQuery params: params format: nil stats: true