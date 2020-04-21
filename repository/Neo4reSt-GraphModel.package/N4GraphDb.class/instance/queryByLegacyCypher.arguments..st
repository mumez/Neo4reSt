actions-deprecated
queryByLegacyCypher: queryString arguments: argsDictionary
	^N4LegacyCypherResult json: (self restClient queryByCypher: queryString params: argsDictionary)