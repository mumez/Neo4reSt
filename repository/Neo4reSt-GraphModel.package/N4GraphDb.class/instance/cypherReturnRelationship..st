cypher-convenience
cypherReturnRelationship: query
	^(self httpClient graphCypher: query) resultDo: [ :result | result firstGraphDo: [ :g | self relationshipClass on: g relationship from: self] ]