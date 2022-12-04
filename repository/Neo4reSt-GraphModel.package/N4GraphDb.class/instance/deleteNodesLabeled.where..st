actions-nodes
deleteNodesLabeled: labelOrLabels where: whereClauseBuilder
	| labels node query |
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labelOrLabels)
		 where: (whereClauseBuilder value: node) delete: node.
	^self cypherStatusOfNodesDeleted: query