actions
getOutRelationshipsAt: nodeId type: type
	^self getOutRelationshipsAt: nodeId types: (Array with: type)