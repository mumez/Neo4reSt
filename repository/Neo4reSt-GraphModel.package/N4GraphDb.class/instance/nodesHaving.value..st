global operations
nodesHaving: key value: value
	| valueParam resp |
	valueParam := self asValueParameter: value.
	resp := self queryByCypher: ('MATCH (n) where n.{1}={2} RETURN id(n)' format: {key. valueParam}).
	^resp result data inject: OrderedCollection new into: [:sum :each | | node|
		node := self nodeClass id: ((each at: 'row') first).
		node db: self.
		sum add: node; yourself].