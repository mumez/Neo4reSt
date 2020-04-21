testing
testBasicCreateNodes
	"self debug: #testBasicCreateNodes"
		
	| node1 node2 relation1 |
	node1 := db createNode.
	node2 := db createNode.
	relation1 := node1 relateTo: node2 type: #follows.
	
	self assert: ((node1 incoming) size = 0).
	initialNodeForTest relateTo: node1 type: #testBasicCreateNodes.
	self assert: ((node1 incoming) size = 1).

	self assert: ((initialNodeForTest outgoing: #testBasicCreateNodes) size = 1).
	self assert: ((node1 allRelationships) size = 2).
	self assert: ((node2 allRelationships) size = 1).
	
	self assert: ((node1 outgoing) size = 1).
	self assert: ((node2 incoming) size = 1).
	
	self assert: (relation1 id = node1 outgoing first id).
	self assert: (relation1 id = node2 incoming first id).
	
	(initialNodeForTest outgoing: #testBasicCreateNodes) first delete.
	
	self assert: ((node1 incoming) size = 0).

