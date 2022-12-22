cypher-convenience
cypherStatusOfContainUpdates: query arguments: arguments
	^(self httpClient statsCypher: query params: arguments asDictionary)
		resultDo: [:r | r containsUpdates ]