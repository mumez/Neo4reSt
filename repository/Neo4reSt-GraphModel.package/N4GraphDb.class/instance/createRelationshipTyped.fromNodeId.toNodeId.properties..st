actions-relationships
createRelationshipTyped: typeOrTypes fromNodeId: startNodeId toNodeId: endNodeId properties: propertiesArray
	| query |
	query := CyQuery
		matchPathWithNodeAt: startNodeId
		nodeAt: endNodeId
		createIn: [ :startNode :endNode :relIdentifier | 
			| rel |
			rel := relIdentifier rel: typeOrTypes props: propertiesArray.
			startNode - rel - endNode ].
	^self cypherReturnRelationship: query