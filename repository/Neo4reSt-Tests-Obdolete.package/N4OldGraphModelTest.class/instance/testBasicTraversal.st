testing
testBasicTraversal
	"self debug: #testBasicTraversal"
		
	| node1 node2 tra1 expectedRoles1 tra2 expectedRoles2|
	node1 := db createNode.
	node2 := db createNode.
	
	self assert: ((node1 incoming) size = 0).
	initialNodeForTest relateTo: node1 type: #testBasicTraversal.
	self assert: ((node1 incoming) size = 1).
	self assert: ((initialNodeForTest outgoing: #testBasicTraversal) size = 1).
	
	1 to: 10 do: [:idx | |newNode |
		newNode := node1 relateToNewNode: ('A>', idx printString).
		newNode relateTo: node2 type: (idx printString, '>B').
	].
	
	tra1 := node1 traversal: [:t | t breadthFirst; returnRelationship; maxDepth: 2].
	self assert: (tra1 size = 11).	
	expectedRoles1 := #('A>1' 'A>10' 'A>2' 'A>3' 'A>4' 'A>5' 'A>6' 'A>7' 'A>8' 'A>9' 'testBasicTraversal').
	self assert: ((tra1 collect: [:each | each type ]) asSortedCollection asArray = expectedRoles1).
	
	tra2 := node2 traversal: [:t | t breadthFirst; returnRelationship; maxDepth: 2].
	self assert: (tra2 size = 10).	
	expectedRoles2 :=  #('10>B' '1>B' '2>B' '3>B' '4>B' '5>B' '6>B' '7>B' '8>B' '9>B').
	self assert: ((tra2 collect: [:each | each type ]) asSortedCollection asArray = expectedRoles2).
	
	(initialNodeForTest outgoing: #testBasicTraversal) first delete.
	
	self assert: ((node1 incoming) size = 0).

