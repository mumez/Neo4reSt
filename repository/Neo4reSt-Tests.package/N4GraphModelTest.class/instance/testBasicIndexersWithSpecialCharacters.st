testing
testBasicIndexersWithSpecialCharacters
	"self debug: #testBasicIndexersWithSpecialCharacters"
		
	| node1 node2 relation1 detectedNode1 detectedNode2 detectedRel1 detectedRel2 |
	node1 := db createNode: (#name-> 'Masashi Umezawa').
	node2 := db createNode: (#name-> 'Smalltalk').
	relation1 := node1 relateTo: node2 type: #users properties: (#years->18).
	
	self assert: ((node1 incoming) size = 0).
	initialNodeForTest relateTo: node1 type: #testBasicIndexersWithSpecialCharacters.
	self assert: ((initialNodeForTest outgoing: #testBasicIndexersWithSpecialCharacters) size = 1).
	
	(db nodeIndexesNamed: 'address') removeAllFor: node1.
	(db nodeIndexesNamed: 'programming languages') removeAllFor: node2.
	(db relationshipIndexesNamed: 'my favorites') removeAllFor: relation1.
	(db relationshipIndexesNamed: 'my shares') removeAllFor: relation1.
	
	(db nodeIndexesNamed: 'address') addKey: #addressEn1 value: 'Tokyo, Japan' for: node1.
	(db nodeIndexesNamed: 'programming languages') addKey: #dialects value: 'Cincom Smalltalk / VW' for: node2.
	(db relationshipIndexesNamed: 'my favorites') addKey: #ratingEn value: 'over 100' for: relation1.
	(db relationshipIndexesNamed: 'my shares') addKey: #'shared with' value: 'You and me!' for: relation1.

	detectedNode1 := (db nodeIndexesNamed: 'address') detectWith: (#addressEn1 -> 'Tokyo, Japan').
	detectedNode2 := (db nodeIndexesNamed: 'programming languages') detectWith: (#dialects -> 'Cincom Smalltalk / VW').
	detectedRel1 := (db relationshipIndexesNamed: 'my favorites') detectWith: (#ratingEn -> 'over 100').
	detectedRel2 := (db relationshipIndexesNamed: 'my shares') detectWith: (#'shared with' -> 'You and me!').
	
	self assert: (node1 = detectedNode1).
	self assert: (node2 = detectedNode2).
	self assert: (relation1 = detectedRel1).
	self assert: (relation1 = detectedRel2).
	
	(db nodeIndexesNamed: 'address') removeAllFor: node1.
	(db nodeIndexesNamed: 'programming languages') removeAllFor: node2.
	(db relationshipIndexesNamed: 'my favorites') removeAllFor: relation1.
	(db relationshipIndexesNamed: 'my shares') removeAllFor: relation1.
	
	detectedNode1 := (db nodeIndexesNamed: 'address') detectWith: (#addressEn1 -> 'Tokyo, Japan').
	detectedNode2 := (db nodeIndexesNamed: 'programming languages') detectWith: (#dialects -> 'Cincom Smalltalk / VW').
	detectedRel1 := (db relationshipIndexesNamed: 'my favorites') detectWith: (#ratingEn -> 'over 100').
	detectedRel2 := (db relationshipIndexesNamed: 'my shares') detectWith: (#'shared with' -> 'You and me!').
		
	self assert: (detectedNode1 isNil).
	self assert: (detectedNode2 isNil).
	self assert: (detectedRel1 isNil).
	self assert: (detectedRel2 isNil).

	(db nodeIndexesNamed: 'address') delete.
	(db nodeIndexesNamed: 'programming languages') delete.
	(db relationshipIndexesNamed: 'my favorites') delete.
	(db relationshipIndexesNamed: 'my shares') delete.
	
	(initialNodeForTest outgoing: #testBasicIndexersWithSpecialCharacters) first delete.
	
	self assert: ((node1 incoming) size = 0).

