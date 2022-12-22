actions-relationships
createInRelationshipTyped: type fromNodeId: startNodeId toNodeId: endNodeId properties: propertiesArray
	| query |
	query := CyQuery
		matchPathWithNodeAt: startNodeId
		nodeAt: endNodeId
		createIn: [ :startNode :endNode :relIdentifier | 
			| rel |
			rel := relIdentifier rel: type props: propertiesArray.
			startNode <- rel - endNode ].
	^self cypherReturnInRelationship: query