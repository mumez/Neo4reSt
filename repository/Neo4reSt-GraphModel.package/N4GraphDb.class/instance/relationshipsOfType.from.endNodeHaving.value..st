global operations
relationshipsOfType: relType from: startNode endNodeHaving: key value: value 
	| valueParam resp |
	valueParam := self asValueParameter: value.
	resp := self queryByCypher: ('MATCH (start)-[r:{1}]-(end) WHERE id(start)={2} AND end.{3}={4} RETURN distinct id(r), type(r), id(startNode(r)), id(endNode(r))' format: {relType. startNode id. key. valueParam}).
	^resp result data inject: OrderedCollection new into: [:sum :each | | row relation |
		row := each at: 'row'.
		relation := self relationshipClass id: (row at: 1).
		relation type: (row at: 2).
		relation startNodeId: (row at: 3).
		relation endNodeId: (row at: 4).
		relation direction: #out.
		relation db: self.
		sum add: relation; yourself].