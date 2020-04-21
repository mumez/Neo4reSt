actions-query
queryByCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean
	| resp |
	resp := self rawClient queryByCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean.
	^N4CypherResponse json: (self portableUtil readJsonFromResponse: resp)