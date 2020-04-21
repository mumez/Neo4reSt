global operations
orphanedNodes
	| resp |
	resp := self queryByCypher: 'START n=node(*)
OPTIONAL MATCH n-[r]-()
WHERE r is null
RETURN id(n)'.
	^resp result data inject: OrderedCollection new into: [:sum :each | | node|
		node := self nodeClass id: ((each at: 'row') first).
		node db: self.
		sum add: node; yourself].