cypher-convenience
cypherReturnNode: query
	^(self httpClient graphCypher: query) resultDo: [ :r | r firstGraphDo: [ :g | self nodeClass on: g node from: self] ]