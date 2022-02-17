global operations
relationshipTypes
	| resp |
	resp := self queryByCypher: 'MATCH (n)-[r]-(m) RETURN distinct type(r)'.
	^resp result data inject: OrderedCollection new into: [:sum :each | sum add: (each at: 'row') first; yourself].