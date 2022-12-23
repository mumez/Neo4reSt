actions-cypher-basic
queryByCypher: queryString arguments: argsDictionary
	^self httpClient queryByCypher: queryString params: argsDictionary asDictionary