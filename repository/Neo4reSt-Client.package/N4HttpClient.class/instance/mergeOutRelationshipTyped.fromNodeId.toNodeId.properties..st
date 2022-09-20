actions-relationships
mergeOutRelationshipTyped: typeOrTypes fromNodeId: startNodeId toNodeId: endNodeId properties: propertiesArray
	| query |
	query := CyQuery
		matchPathWithNodeAt: startNodeId
		nodeAt: endNodeId
		mergeIn: [ :startNode :endNode :relIdentifier | 
			| rel |
			rel := relIdentifier rel: typeOrTypes props: propertiesArray.
			startNode - rel -> endNode ].
	^(self graphCypher: query) resultDo: [ :result | result firstGraphDo: [ :g | g relationship beIn] ]