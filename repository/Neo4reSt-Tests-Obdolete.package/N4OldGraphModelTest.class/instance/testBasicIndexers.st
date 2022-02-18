testing
testBasicIndexers
	"self debug: #testBasicIndexers"
		
	| node1 node2 relation1 detectedNode1 detectedNode2 detectedRel1 |
	node1 := db createNode: (#name-> 'Masashi Umezawa').
	node2 := db createNode: (#name-> 'Smalltalk').
	relation1 := node1 relateTo: node2 type: #users properties: (#years->18).
	
	self assert: ((node1 incoming) size = 0).
	initialNodeForTest relateTo: node1 type: #testBasicIndexers.
	self assert: ((initialNodeForTest outgoing: #testBasicIndexers) size = 1).
	
	(db nodeIndexesNamed: 'people') addKey: #initial value: 'mu' for: node1.
	(db nodeIndexesNamed: 'programming languages') addKey: #extension value: 'st' for: node2.
	(db relationshipIndexesNamed: 'favorites') addKey: #rating value: 100 for: relation1.

	detectedNode1 := (db nodeIndexesNamed: 'people') detectWith: (#initial -> 'mu').
	detectedNode2 := (db nodeIndexesNamed: 'programming languages') detectWith: (#extension -> 'st').
	detectedRel1 := (db relationshipIndexesNamed: 'favorites') detectWith: (#rating -> 100).
	
	self assert: (node1 = detectedNode1).
	self assert: (node2 = detectedNode2).
	self assert: (relation1 = detectedRel1).
	
	(db nodeIndexesNamed: 'people') removeAllFor: node1.
	(db nodeIndexesNamed: 'programming languages') removeAllFor: node2.
	(db relationshipIndexesNamed: 'favorites') removeAllFor: relation1.
	
	detectedNode1 := (db nodeIndexesNamed: 'people') detectWith: (#initial -> 'mu').
	detectedNode2 := (db nodeIndexesNamed: 'programming languages') detectWith: (#extension -> 'st').
	detectedRel1 := (db relationshipIndexesNamed: 'favorites') detectWith: (#rating -> 100).
	
	self assert: (detectedNode1 isNil).
	self assert: (detectedNode2 isNil).
	self assert: (detectedRel1 isNil).

	(db nodeIndexesNamed: 'people') delete.
	(db nodeIndexesNamed: 'programming languages') delete.
	(db relationshipIndexesNamed: 'favorites') delete.
	
	(initialNodeForTest outgoing: #testBasicIndexers) first delete.
	
	self assert: ((node1 incoming) size = 0).

