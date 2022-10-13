actions-relationships
mergeOutRelationshipTyped: type fromNodeId: startNodeId toNodeId: endNodeId properties: propertiesArray
	| query |
	query := CyQuery
		matchPathWithNodeAt: startNodeId
		nodeAt: endNodeId
		mergeIn: [ :startNode :endNode :relIdentifier | 
			| rel |
			rel := relIdentifier rel: type props: propertiesArray.
			startNode - rel -> endNode ].
	^self cypherReturnOutRelationship: query