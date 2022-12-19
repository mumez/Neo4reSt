testing
testMergeNodes
	self dbDo: [ :db | | node1 node2 node3 node4 node5 lastAccess node |
		node1 := db mergeNodeLabeled: 'label1'.
		node2 := db mergeNodeLabeled: 'label1'.
		self assert: node1 id = node2 id equals: true.
		node3 := db mergeNodeLabeled: 'label1' properties: {#counter -> 1}.
		node4 := db mergeNodeLabeled: 'label1' properties: {#counter -> 2}.
		node5 := db mergeNodeLabeled: 'label1' properties: {#counter -> 1}.
		self assert: node3 id = node4 id equals: false.
		self assert: node3 id = node5 id equals: true.
		
		lastAccess := 123.
		1 to: 3 do: [ :each |
			node := db mergeNodeLabeled: 'label2' havingAll: {#index -> each} onCreateSet: [:n | n @ 'index' to: each ] onMatchSet: [:n | n @ 'lastAccess' to: lastAccess ].
			self assert: (node @ #index) equals: each.
			self assert: (node @ #lastAccess) equals: nil.	
		].
		1 to: 3 do: [ :each |
			node := db mergeNodeLabeled: 'label2' havingAll: {#index -> each} onCreateSet: [:n | n @ 'index' to: each * 2 ] onMatchSet: [:n | n @ 'lastAccess' to: lastAccess ].
			self assert: (node @ #index) equals: each.
			self assert: (node @ #lastAccess) equals: 123.	
		].

		db deleteNodesLabeled: 'label1'.
		self assert: (db countNodesLabeled: 'lanel1') equals: 0.
		db deleteNodesLabeled: 'label2'.
		self assert: (db countNodesLabeled: 'label2') equals: 0.
	]