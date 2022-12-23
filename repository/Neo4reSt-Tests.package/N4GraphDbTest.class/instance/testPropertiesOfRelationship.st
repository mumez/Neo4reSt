testing
testPropertiesOfRelationship
	self dbDo: [ :db | | nodeCreated1 nodeCreated2 outRelCreated outRelRetrieved deletedResult deletedRelRetrieved |
		nodeCreated1 := db createNodeLabeled: 'test'.
		nodeCreated2 := db createNodeLabeled: 'test'.
		outRelCreated := db createInRelationshipTyped: 'REL1' fromNodeId: nodeCreated1 id toNodeId: nodeCreated2 id properties: {#a->1}.
		outRelRetrieved := db relationshipAt: outRelCreated id.
		self assert: (outRelRetrieved propertyAt: #a) equals: 1.
		outRelRetrieved propertyAt: #b put: 2.
		self assert: (outRelRetrieved propertyAt: #b) equals: 2.
		outRelRetrieved mergeProperties: {#b -> 3. #c -> 4}.
		self assert: (outRelRetrieved propertyAt: #a) equals: 1.
		self assert: (outRelRetrieved propertyAt: #b) equals: 3.
		self assert: (outRelRetrieved propertyAt: #c) equals: 4.
		outRelRetrieved properties: {#a -> 0}.
		self assert: (outRelRetrieved propertyAt: #a) equals: 0.
		self assert: (outRelRetrieved propertyAt: #b) equals: nil.
		self assert: (outRelRetrieved propertyAt: #c) equals: nil.
		outRelRetrieved removePropertyAt: #a.
		self assert: (outRelRetrieved propertyAt: #a) equals: nil.
		deletedResult := outRelRetrieved delete.
		self assert: deletedResult equals: true.
		deletedRelRetrieved := db relationshipAt: outRelRetrieved id.
		self assert: deletedRelRetrieved equals: nil.
		self assert: (db deleteNodeAt: nodeCreated1 id) equals: true.
		self assert: (db deleteNodeAt: nodeCreated2 id) equals: true.
	]