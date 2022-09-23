cypher-convenience
cypherReturnOutRelationship: query
	^(self httpClient graphCypher: query) resultDo: [ :result | result firstGraphDo: [ :g | g relationship beIn] ]