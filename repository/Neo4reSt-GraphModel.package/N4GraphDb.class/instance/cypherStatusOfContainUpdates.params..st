cypher-convenience
cypherStatusOfContainUpdates: query params: params
	^(self httpClient statsCypher: query params: params asDictionary)
		resultDo: [:r | r containsUpdates ]