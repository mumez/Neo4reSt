cypher-convenience
cypherReturnNode: query
	^(self httpClient graphCypher: query) resultDo: [ :r | r firstGraphDo: [ :g | g node] ]