actions-relationships
mergeInRelationshipTyped: typeOrTypes fromNodeId: startNodeId toNodeId: endNodeId properties: propertiesArray
	| query |
	query := CyQuery
		matchPathWithNodeAt: startNodeId
		nodeAt: endNodeId
		mergeIn: [ :startNode :endNode :relIdentifier | 
			| rel |
			rel := relIdentifier rel: typeOrTypes props: propertiesArray.
			startNode <- rel - endNode ].
	^self cypherReturnInRelationship: query