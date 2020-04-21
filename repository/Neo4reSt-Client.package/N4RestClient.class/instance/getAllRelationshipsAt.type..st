actions
getAllRelationshipsAt: nodeId type: type
	^self getAllRelationshipsAt: nodeId types: (Array with: type)