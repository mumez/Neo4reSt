actions-cypher
graphCypher: cypherQuery params: params stats: aBoolean
	^self runCypher: cypherQuery params: params format: #graph stats: aBoolean