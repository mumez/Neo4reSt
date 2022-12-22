testing
testCreateDeleteNodes
	self dbDo: [ :db | | nodeCreated nodeRetrieved deletedResult deletedNodeRetrieved |
		nodeCreated := db createNodeLabeled: 'test' properties: {#a -> 1}.	
		nodeRetrieved := db nodeAt: nodeCreated id.
		self assert: nodeRetrieved id equals: nodeCreated id.
		self assert: (nodeRetrieved propertyAt: #a) equals: 1.
		deletedResult := nodeRetrieved delete.
		self assert: deletedResult equals: true.
		deletedNodeRetrieved := db nodeAt: nodeCreated id.
		self assert: deletedNodeRetrieved equals: nil.
	]