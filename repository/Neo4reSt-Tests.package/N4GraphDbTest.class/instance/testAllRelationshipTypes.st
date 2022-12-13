testing
testAllRelationshipTypes
	| rel1 rel2 rel3 rel4 |
	self dbDo: [ :db | | node1 node2 node3 node4 |
		node1 := db createNodeLabeled: 'label1'.	
		node2 := db createNodeLabeled: 'label1'.
		node3 := db createNodeLabeled: 'label1'.
		node4 := db createNodeLabeled: 'label1'.	
		rel1 := node1 relateOneTo: node2 typed: 'REL1'.
		rel2 := node2 relateOneTo: node1 typed: 'REL2'.
		rel3 := node3 relateOneTo: node4 typed: 'REL3'.
		rel4 := node4 relateOneTo: node3 typed: 'REL2'.
		self assert: db allRelationshipTypes asArray sorted equals: #('REL1' 'REL2' 'REL3').
		rel1 delete.
		rel2 delete.
		self assert: db allRelationshipTypes asArray sorted equals: #('REL2' 'REL3').
		rel3 delete.
		rel4 delete.
		self assert: db allRelationshipTypes asArray sorted equals: #().
		db deleteNodesLabeled: 'label1'
	]