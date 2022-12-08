actions-nodes
nodesLabeled: labelOrLabels where: whereClauseBuilder skip: skip limit: limit
	| node query |
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labelOrLabels)
		 where: (whereClauseBuilder value: node) return: node skip: skip limit: limit.
	^ self cypherReturnNodes: query