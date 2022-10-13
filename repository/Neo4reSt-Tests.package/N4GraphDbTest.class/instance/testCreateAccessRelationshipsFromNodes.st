testing
testCreateAccessRelationshipsFromNodes
	self dbDo: [ :db | | nodeCreated1 nodeCreated2 inRelCreated1 inRelCreated2 inRelCreated3 inRelCreated4 inRelCreated5 inRelsRetrieved1 inRelRetrieved1 inRelsRetrieved2 inRelRetrieved2 inRelsRetrieved3 |
		nodeCreated1 := db createNodeLabeled: 'test'.
		nodeCreated2 := db createNodeLabeled: 'test'.
		inRelCreated1 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL1 properties: {#a->1}.
		inRelCreated2 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL2 properties: {}.
		inRelCreated3 := nodeCreated1 relateTo: nodeCreated2 typed: #REL3 properties: {}.
		inRelCreated4 := nodeCreated1 relateTo: nodeCreated2 typed: #REL3 properties: {}.
		inRelCreated5 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL1 properties: {#b->2}.
		
		inRelsRetrieved1 := nodeCreated1 outRelationshipsTyped: #REL1.
		self assert: (inRelsRetrieved1 size) equals: 1.
		inRelRetrieved1 := inRelsRetrieved1 first.
		self assert: inRelRetrieved1 properties asDictionary associations equals: {#b->2} asDictionary associations.
		
		inRelsRetrieved2 := nodeCreated1 outRelationshipsTyped: #REL2.
		self assert: (inRelsRetrieved2 size) equals: 1.
		inRelRetrieved2 := inRelsRetrieved2 first.
		
		inRelsRetrieved3 := nodeCreated1 outRelationshipsTyped: #REL3.
		self assert: (inRelsRetrieved3 size) equals: 2.
		
		self assert: (nodeCreated1 outRelationships size) equals: 4.
		
		self assert: inRelRetrieved1 delete equals: true.
		self assert: inRelRetrieved2 delete equals: true.
		inRelsRetrieved3 do: [ :each | 
			self assert: each delete equals: true.
		].
		self assert: nodeCreated1 delete equals: true.
		self assert: nodeCreated1 delete equals: true.
	]