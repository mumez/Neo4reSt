testing
testBasicCreateNodesWithProperties
	"self debug: #testBasicCreateNodesWithProperties"
		
	| node1 node2 relation1 |
	node1 := db createNode: (#name-> 'start').
	node2 := db createNode: (#name-> 'end').
	relation1 := node1 relateTo: node2 type: #follows properties: (#score->100).
	
	self assert: ((node1 incoming) size = 0).
	initialNodeForTest relateTo: node1 type: #testBasicCreateNodesWithProperties.
	self assert: ((node1 incoming) size = 1).

	self assert: ((initialNodeForTest outgoing: #testBasicCreateNodesWithProperties) size = 1).
		
	self assert: ((node1 propertyAt: #name) = 'start').
	self assert: ((node2 propertyAt: #name) = 'end').
	self assert: ((relation1 propertyAt: #score) = 100).
	
	self assert: (node1 properties size = 1).
	node1 propertyAt: #name put: 'START'.
	self assert: ((node1 propertyAt: #name) = 'START').

	self assert: (relation1 properties size = 1).
	relation1 propertyAt: #score put: ((relation1 propertyAt: #score) + 200).
	self assert: ((relation1 propertyAt: #score) = 300).
	
	node2 propertyAt: #address put: 'Tokyo'.
	self assert: (node2 properties size = 2).
	
	node1 removePropertyAt: #name.
	node2 removePropertyAt: #name.
	relation1 removePropertyAt: #score.
	
	self assert: (node1 properties size = 0).
	self assert: (node2 properties size = 1).
	self assert: (relation1 properties size = 0).
	
	(initialNodeForTest outgoing: #testBasicCreateNodesWithProperties) first delete.
	
	self assert: ((node1 incoming) size = 0).

