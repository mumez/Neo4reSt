actions-nodes
nodesLabeled: labelOrLabels where: whereClauseBuilder
	| node query |
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labelOrLabels)
		 where: (whereClauseBuilder value: node) return: node.
	^(self httpClient graphCypher: query) resultDo: [ :r | r firstGraphDo: [ :g | g nodes] ifNone: [ #() ] ]