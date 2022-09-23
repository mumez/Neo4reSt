cypher-convenience
cypherReturnRelationship: query
	^(self httpClient graphCypher: query) resultDo: [ :result | result firstGraphDo: [ :g | g relationship ] ]