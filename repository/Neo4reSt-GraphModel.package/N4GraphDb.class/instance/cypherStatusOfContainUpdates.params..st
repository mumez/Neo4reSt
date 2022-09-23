cypher-convenience
cypherStatusOfContainUpdates: query params: params
	^(self httpClient statsCypher: query params: params)
		resultDo: [:r | r containsUpdates ]