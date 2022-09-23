cypher-convenience
cypherStatusOfRelationshipDeleted: query
	^(self httpClient statsCypher: query) resultDo: [:result | result relationshipDeleted > 0]