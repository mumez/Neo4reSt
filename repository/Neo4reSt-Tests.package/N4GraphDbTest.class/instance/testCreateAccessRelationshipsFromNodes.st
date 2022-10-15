testing
testCreateAccessRelationshipsFromNodes
	self dbDo: [ :db | | nodeCreated1 nodeCreated2 outRelCreated1 outRelCreated2 outRelCreated3 outRelCreated4 outRelCreated5 outRelsRetrieved1 outRelRetrieved1 outRelsRetrieved2 outRelRetrieved2 outRelsRetrieved3 |
		nodeCreated1 := db createNodeLabeled: 'test'.
		nodeCreated2 := db createNodeLabeled: 'test'.
		outRelCreated1 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL1 properties: {#a->1}.
		outRelCreated2 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL2 properties: {}.
		outRelCreated3 := nodeCreated1 relateTo: nodeCreated2 typed: #REL3 properties: {}.
		outRelCreated4 := nodeCreated1 relateTo: nodeCreated2 typed: #REL3 properties: {}.
		outRelCreated5 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL1 properties: {#b->2}.
		
		outRelsRetrieved1 := nodeCreated1 outRelationshipsTyped: #REL1.
		self assert: (outRelsRetrieved1 size) equals: 1.
		outRelRetrieved1 := outRelsRetrieved1 first.
		self assert: outRelRetrieved1 properties asDictionary associations equals: {#b->2} asDictionary associations.
		
		outRelsRetrieved2 := nodeCreated1 outRelationshipsTyped: #REL2.
		self assert: (outRelsRetrieved2 size) equals: 1.
		outRelRetrieved2 := outRelsRetrieved2 first.
		
		outRelsRetrieved3 := nodeCreated1 outRelationshipsTyped: #REL3.
		self assert: (outRelsRetrieved3 size) equals: 2.
		
		self assert: (nodeCreated1 outRelationships size) equals: 4.
		
		self assert: outRelRetrieved1 delete equals: true.
		self assert: outRelRetrieved2 delete equals: true.
		outRelsRetrieved3 do: [ :each | 
			self assert: each delete equals: true.
		].
		self assert: nodeCreated1 delete equals: true.
		self assert: nodeCreated1 delete equals: true.
	]