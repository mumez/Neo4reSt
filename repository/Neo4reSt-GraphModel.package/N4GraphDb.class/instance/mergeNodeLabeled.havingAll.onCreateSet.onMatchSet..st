actions-nodes
mergeNodeLabeled: labelOrLabels havingAll: properties onCreateSet: createSetExpression onMatchSet: matchSetExpression
	| n node query merge |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n labels: labelOrLabels props: properties.
	query := CyQuery match: node.
	merge := CyMerge of: node.
	merge onCreateSet: createSetExpression.
	merge onMatchSet: matchSetExpression.
	query := CyQuery statements: {
		merge.
		CyReturn of: n.
	}.
	^self cypherReturnNode: query