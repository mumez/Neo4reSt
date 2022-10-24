testing
testExistsRelationshipsFromNodes
	self dbDo: [ :db | | nodeCreated1 nodeCreated2 outRelCreated1 outRelCreated2 outRelCreated3 outRelCreated4 outRelCreated5 outRelRetrieved1 outRelRetrieved2 outRelsRetrieved3 |
		nodeCreated1 := db createNodeLabeled: 'test'.
		nodeCreated2 := db createNodeLabeled: 'test'.
		outRelCreated1 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL1 properties: {#a->1}.
		outRelCreated2 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL2 properties: {}.
		outRelCreated3 := nodeCreated1 relateTo: nodeCreated2 typed: #REL3 properties: {}.
		outRelCreated4 := nodeCreated1 relateTo: nodeCreated2 typed: #REL3 properties: {}.
		outRelCreated5 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL1 properties: {#a->1}.
		
		self assert: (nodeCreated1 existsRelationshipTyped: #REL1).
		self assert: (nodeCreated1 existsOutRelationshipTyped: #REL1).
		self deny: (nodeCreated1 existsInRelationshipTyped: #REL1).
		self assert: (nodeCreated1 existsOutRelationshipTyped: #REL1 having: #a value: 1).
		self deny: (nodeCreated1 existsOutRelationshipTyped: #REL1 having: #a value: 2).
		self deny: (nodeCreated1 existsOutRelationshipTyped: #REL1 having: #b value: 1).
		
		self assert: (nodeCreated1 existsRelationshipTyped: #REL2).
		self assert: (nodeCreated1 existsOutRelationshipTyped: #REL2).
		self deny: (nodeCreated1 existsInRelationshipTyped: #REL2).
		
		self assert: (nodeCreated1 existsRelationshipTyped: #REL3).
		self assert: (nodeCreated1 existsOutRelationshipTyped: #REL3).
		self deny: (nodeCreated1 existsInRelationshipTyped: #REL3).
		
		outRelRetrieved1 := (nodeCreated1 outRelationshipsTyped: #REL1) first.
		outRelRetrieved2 := (nodeCreated1 outRelationshipsTyped: #REL2) first.
		outRelsRetrieved3 := nodeCreated1 outRelationshipsTyped: #REL3.
		
		self assert: outRelRetrieved1 delete equals: true.
		self assert: outRelRetrieved2 delete equals: true.
		outRelsRetrieved3 do: [ :each | 
			self assert: each delete equals: true.
		].
		self deny: (nodeCreated1 existsRelationshipTyped: #REL1).
		self deny: (nodeCreated1 existsRelationshipTyped: #REL2).
		self deny: (nodeCreated1 existsRelationshipTyped: #REL3).
	
		self assert: nodeCreated1 delete equals: true.
		self assert: nodeCreated2 delete equals: true.
	]