global operations
nodesLabeled: label limit: limit
	| resp |
	resp := self queryByCypher: ('MATCH (n:{1}) RETURN id(n) LIMIT {2}' format: {label. limit}).
	^resp result data inject: OrderedCollection new into: [:sum :each | | node|
		node := self nodeClass id: ((each at: 'row') first).
		node db: self.
		sum add: node; yourself].