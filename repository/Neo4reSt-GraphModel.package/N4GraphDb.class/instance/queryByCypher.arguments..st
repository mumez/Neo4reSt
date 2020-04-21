actions-cypher
queryByCypher: queryString arguments: argsDictionary
	^self restClient queryByCypher: queryString params: argsDictionary