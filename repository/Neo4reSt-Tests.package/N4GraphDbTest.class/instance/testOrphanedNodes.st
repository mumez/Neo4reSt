testing
testOrphanedNodes
	self dbDo: [ :db | | node1 node2 rel1 rel2 orphanedNodes |
		node1 := db createNodeLabeled: 'label1'.
		node2 := db createNodeLabeled: 'label1'.
		rel1 := node1 relateTo: node2 typed: 'type1'.
		rel2 := node1 relateTo: node2 typed: 'type1'.
		
		self assert: (node1 outRelationshipsTyped: 'type1') size equals: 2.
		self assert: (node2 outRelationshipsTyped: 'type1') size equals: 0.
		self assert: db orphanedNodes size equals: 0.
		
		rel1 delete.
		rel2 delete.
		
		self assert: (node1 outRelationshipsTyped: 'type1') size equals: 0.
		self assert: (node2 outRelationshipsTyped: 'type1') size equals: 0.
		
		orphanedNodes := db orphanedNodes.
		self assert: orphanedNodes size equals: 2.
		
		orphanedNodes do: [ :each | each delete ].
		self assert: (db countNodesLabeled: 'label1') equals: 0.
		self assert: (db countRelationshipsTyped: 'type1') equals: 0.
	]