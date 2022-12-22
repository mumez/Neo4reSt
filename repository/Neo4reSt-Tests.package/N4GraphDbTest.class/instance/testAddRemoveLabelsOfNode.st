testing
testAddRemoveLabelsOfNode
	self dbDo: [ :db | | nodeCreated nodeRetrieved deletedResult |
		nodeCreated := db createNodeLabeled: 'label1'.	
		nodeRetrieved := db nodeAt: nodeCreated id.
		self assert: nodeRetrieved labels equals: #('label1').
		nodeRetrieved addLabel: 'label2'.
		self assert: nodeRetrieved labels sorted equals: #('label1' 'label2').
		nodeRetrieved addLabels: #('label3' 'label4').
		self assert: nodeRetrieved labels sorted equals: #('label1' 'label2' 'label3' 'label4').
		nodeRetrieved removeLabels: #('label1' 'label2').
		self assert: nodeRetrieved labels sorted equals: #('label3' 'label4').
		nodeRetrieved removeLabel: 'label3'.
		self assert: nodeRetrieved labels sorted equals: #('label4').
		deletedResult := nodeRetrieved delete.
		self assert: deletedResult equals: true.
	]