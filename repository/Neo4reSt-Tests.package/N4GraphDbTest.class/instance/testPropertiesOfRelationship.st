testing
testPropertiesOfRelationship
	self dbDo: [ :db | | nodeCreated1 nodeCreated2 inRelCreated inRelRetrieved deletedResult deletedRelRetrieved |
		nodeCreated1 := db createNodeLabeled: 'test'.
		nodeCreated2 := db createNodeLabeled: 'test'.
		inRelCreated := db createInRelationshipTyped: 'REL1' fromNodeId: nodeCreated1 id toNodeId: nodeCreated2 id properties: {#a->1}.
		inRelRetrieved := db relationshipAt: inRelCreated id.
		self assert: (inRelRetrieved propertyAt: #a) equals: 1.
		inRelRetrieved propertyAt: #b put: 2.
		self assert: (inRelRetrieved propertyAt: #b) equals: 2.
		inRelRetrieved mergeProperties: {#b -> 3. #c -> 4}.
		self assert: (inRelRetrieved propertyAt: #a) equals: 1.
		self assert: (inRelRetrieved propertyAt: #b) equals: 3.
		self assert: (inRelRetrieved propertyAt: #c) equals: 4.
		inRelRetrieved properties: {#a -> 0}.
		self assert: (inRelRetrieved propertyAt: #a) equals: 0.
		self assert: (inRelRetrieved propertyAt: #b) equals: nil.
		self assert: (inRelRetrieved propertyAt: #c) equals: nil.
		inRelRetrieved removePropertyAt: #a.
		self assert: (inRelRetrieved propertyAt: #a) equals: nil.
		deletedResult := inRelRetrieved delete.
		self assert: deletedResult equals: true.
		deletedRelRetrieved := db relationshipAt: inRelRetrieved id.
		self assert: deletedRelRetrieved equals: nil.
	]