private
relationshipsFromCypherResponse: resp
	resp hasErrors ifTrue: [ ^#() ].
	^resp result data inject: OrderedCollection new into: [:sum :each | | row relation |
		row := each at: 'row'.
		relation := self relationshipClass id: (row at: 1).
		relation type: (row at: 2).
		relation startNodeId: (row at: 3).
		relation endNodeId: (row at: 4).
		relation direction: #out.
		relation db: self.
		sum add: relation; yourself].