global operations
relationshipsOfType: relType
	| resp |
	resp := self queryByCypher: ('MATCH ()-[r:{1}]-() RETURN distinct id(r), type(r), id(startNode(r)), id(endNode(r))' format: {relType}).
	^resp result data inject: OrderedCollection new into: [:sum :each | | row relation |
		row := each at: 'row'.
		relation := self relationshipClass id: (row at: 1).
		relation type: (row at: 2).
		relation startNodeId: (row at: 3).
		relation endNodeId: (row at: 4).
		relation direction: #out.
		relation db: self.
		sum add: relation; yourself].