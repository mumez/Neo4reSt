testing
testAllLabels
	self dbDo: [ :db | | node1 node2 node3 node4 |
		node1 := db createNodeLabeled: 'label1'.	
		node2 := db createNodeLabeled: 'label2'.	
		node3 := db createNodeLabeled: 'label3'.
		node4 := db createNodeLabeled: 'label2'.
		self assert: db allLabels asArray sorted equals: #('label1' 'label2' 'label3').
		node1 delete.
		node2 delete.
		self assert: db allLabels asArray sorted equals: #('label2' 'label3').
		node3 delete.
		node4 delete.
		self assert: db allLabels asArray sorted equals: #().
	]