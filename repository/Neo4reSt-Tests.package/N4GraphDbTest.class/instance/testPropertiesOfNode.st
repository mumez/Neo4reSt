testing
testPropertiesOfNode
	self dbDo: [ :db | | nodeCreated nodeRetrieved deletedResult deletedNodeRetrieved |
		nodeCreated := db createNodeLabeled: 'test' properties: {#a -> 1}.	
		nodeRetrieved := db nodeAt: nodeCreated id.
		self assert: (nodeRetrieved propertyAt: #a) equals: 1.
		nodeRetrieved propertyAt: #b put: 2.
		self assert: (nodeRetrieved propertyAt: #b) equals: 2.
		nodeRetrieved mergeProperties: {#b -> 3. #c -> 4}.
		self assert: (nodeRetrieved propertyAt: #a) equals: 1.
		self assert: (nodeRetrieved propertyAt: #b) equals: 3.
		self assert: (nodeRetrieved propertyAt: #c) equals: 4.
		nodeRetrieved properties: {#a -> 0}.
		self assert: (nodeRetrieved propertyAt: #a) equals: 0.
		deletedResult := nodeRetrieved delete.
		self assert: deletedResult equals: true.
		deletedNodeRetrieved := db nodeAt: nodeCreated id.
		self assert: deletedNodeRetrieved equals: nil.
	]