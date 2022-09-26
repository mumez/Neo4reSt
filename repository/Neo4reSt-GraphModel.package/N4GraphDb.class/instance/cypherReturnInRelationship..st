cypher-convenience
cypherReturnInRelationship: query
	^(self httpClient graphCypher: query) resultDo: [ :result | result firstGraphDo: [ :g | self relationshipClass on: g relationship beIn from: self] ]