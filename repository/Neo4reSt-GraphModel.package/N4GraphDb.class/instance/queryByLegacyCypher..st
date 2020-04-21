actions-deprecated
queryByLegacyCypher: queryString
	^N4LegacyCypherResult json: (self restClient queryByCypher: queryString)