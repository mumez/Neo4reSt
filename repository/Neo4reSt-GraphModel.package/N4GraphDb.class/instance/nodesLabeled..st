global operations
nodesLabeled: label
	| resp |
	resp := self queryByCypher: ('MATCH (n:{1}) RETURN id(n)' format: {label}).
	^resp result data inject: OrderedCollection new into: [:sum :each | | node|
		node := self nodeClass id: ((each at: 'row') first).
		node db: self.
		sum add: node; yourself].