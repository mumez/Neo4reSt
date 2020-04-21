private
nodesFromCypherResponse: resp
	resp hasErrors ifTrue: [ ^#() ].
	^resp result data inject: OrderedCollection new into: [:sum :each | | node|
		node := self nodeClass id: ((each at: 'row') first).
		node db: self.
		sum add: node; yourself].