testing
testMergeNodes
	self dbDo: [ :db | | node1 node2 node3 node4 node5 |
		node1 := db mergeNodeLabeled: 'label1'.
		node2 := db mergeNodeLabeled: 'label1'.
		self assert: node1 id = node2 id equals: true.
		node3 := db mergeNodeLabeled: 'label1' properties: {#counter -> 1}.
		node4 := db mergeNodeLabeled: 'label1' properties: {#counter -> 2}.
		node5 := db mergeNodeLabeled: 'label1' properties: {#counter -> 1}.
		self assert: node3 id = node4 id equals: false.
		self assert: node3 id = node5 id equals: true.
		db deleteNodesLabeled: 'label1'.
		self assert: (db countNodesLabeled: 'lanel1') equals: 0.
	]