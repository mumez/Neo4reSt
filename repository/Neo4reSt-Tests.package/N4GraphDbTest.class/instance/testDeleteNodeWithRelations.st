testing
testDeleteNodeWithRelations
	self dbDo: [ :db | | node1 node2 rel1 rel2 rel3 rel4 |
		node1 := db createNodeLabeled: 'label1'.	
		node2 := db createNodeLabeled: 'label2'.
		rel1 := node1 relateTo: node2 typed: 'REL1'.
		rel2 := node1 relateTo: node2 typed: 'REL1'.
		rel3 := node2 relateTo: node1 typed: 'REL1'.
		rel4 := node2 relateTo: node1 typed: 'REL1'.
		
		self assert: (db countRelationshipsTyped: 'REL1') equals: 4.
		node1 deleteWithRelations.
		
		self assert: (db countRelationshipsTyped: 'REL1') equals: 0.
		node2 delete.
	
		self assert: (db countNodesLabeled: #('label1' 'label2')) equals: 0.
	]