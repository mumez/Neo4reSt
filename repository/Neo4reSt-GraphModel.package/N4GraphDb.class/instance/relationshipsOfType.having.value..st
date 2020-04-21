global operations
relationshipsOfType: relType having: key value: value 
	| valueParam resp |
	valueParam := self asValueParameter: value.
	resp := self queryByCypher: ('MATCH ()-[r:{1}]-() WHERE where r.{2}={3} RETURN distinct id(r), type(r), id(startNode(r)), id(endNode(r))' format: {relType. key. valueParam}).
	^resp result data inject: OrderedCollection new into: [:sum :each | | row relation |
		row := each at: 'row'.
		relation := self relationshipClass id: (row at: 1).
		relation type: (row at: 2).
		relation startNodeId: (row at: 3).
		relation endNodeId: (row at: 4).
		relation direction: #out.
		relation db: self.
		sum add: relation; yourself].