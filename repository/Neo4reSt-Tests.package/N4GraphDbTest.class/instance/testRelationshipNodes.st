testing
testRelationshipNodes
	self dbDo: [ :db | | node1 node2 inRel outRel |
		node1 := db mergeNodeLabeled: 'label1' properties: {#name -> 'name-in'}.
		node2 := db mergeNodeLabeled: 'label2' properties: {#name -> 'name-out'}.
		node1 relateOneTo: node2 typed: 'REL_OUT'.
		node2 relateOneTo: node1 typed: 'REL_IN'.
		
		inRel := (node1 inRelationshipsTyped: 'REL_IN') first.
		outRel := (node1 outRelationshipsTyped: 'REL_OUT') first.
		
		self assert: (inRel startNode @ 'name') equals: 'name-out'.
		self assert: (inRel endNode @ 'name') equals: 'name-in'.
		self assert: (inRel headNode @ 'name') equals: 'name-in'.
		self assert: (inRel tailNode @ 'name') equals: 'name-out'.
		
		self assert: (outRel startNode @ 'name') equals: 'name-in'.
		self assert: (outRel endNode @ 'name') equals: 'name-out'.
		self assert: (outRel headNode @ 'name') equals: 'name-out'.
		self assert: (outRel tailNode @ 'name') equals: 'name-in'.
		
		node1 deleteWithRelations.
		node2 deleteWithRelations.
		
		self assert: (db countNodesLabeled: 'label1') equals: 0.
		self assert: (db countNodesLabeled: 'label2') equals: 0.
		self assert: (db countRelationshipsTyped: 'REL_IN') equals: 0.
		self assert: (db countRelationshipsTyped: 'REL_OUT') equals: 0.
	]