cypher-convenience
cypherStatusOfNodesDeleted: query
	^(self httpClient statsCypher: query) resultDo: [:r | r nodesDeleted > 0]