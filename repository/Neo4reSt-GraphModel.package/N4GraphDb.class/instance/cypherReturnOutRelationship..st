cypher-convenience
cypherReturnOutRelationship: query
	^(self httpClient graphCypher: query) resultDo: [ :result | result firstGraphDo: [ :g | self relationshipClass on: g relationship beOut from: self] ]