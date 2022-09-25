testing
testCreateDeleteRelationships
	self dbDo: [ :db | | nodeCreated1 nodeCreated2 inRelCreated outRelCreated inRelRetrieved outRelRetrieved deletedInRel deletedOutRel |
		nodeCreated1 := db createNodeLabeled: 'test'.
		nodeCreated2 := db createNodeLabeled: 'test'.
		inRelCreated := db createInRelationshipTyped: 'REL1' fromNodeId: nodeCreated1 id toNodeId: nodeCreated2 id properties: {#a->1}.
		outRelCreated := db createOutRelationshipTyped: 'REL1' fromNodeId: nodeCreated1 id toNodeId: nodeCreated2 id properties: {#a->2}.
		inRelRetrieved := db relationshipAt: inRelCreated id.
		outRelRetrieved := db relationshipAt: outRelCreated id.
		self assert: inRelRetrieved id equals: inRelCreated id.
		self assert: outRelRetrieved id equals: outRelCreated id.
		self assert: inRelCreated direction equals: #in.
		self assert: outRelCreated direction equals: #out.
		self assert: (inRelRetrieved propertyAt: #a) equals: 1.
		self assert: (outRelRetrieved propertyAt: #a) equals: 2.
		deletedInRel := db deleteRelationshipAt: inRelRetrieved id.
		deletedOutRel := db deleteRelationshipAt: outRelRetrieved id.
		self assert: deletedInRel equals: true.
		self assert: deletedOutRel equals: true.
		self assert: (db relationshipAt: inRelCreated id) equals: nil.
		self assert: (db relationshipAt: outRelCreated id) equals: nil.
		self assert: (db deleteNodeAt: nodeCreated1 id) equals: true.
		self assert: (db deleteNodeAt: nodeCreated2 id) equals: true.
	]