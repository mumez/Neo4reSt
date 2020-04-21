actions
getInRelationshipsAt: nodeId type: type
	^self getInRelationshipsAt: nodeId types: (Array with: type)