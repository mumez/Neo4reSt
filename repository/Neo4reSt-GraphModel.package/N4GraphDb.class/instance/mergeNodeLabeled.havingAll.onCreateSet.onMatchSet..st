actions-nodes
mergeNodeLabeled: labelOrLabels havingAll: properties onCreateSet: createSetExpressionBuilder onMatchSet: matchSetExpressionBuilder
	| n node query merge |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n labels: labelOrLabels props: properties.
	query := CyQuery match: node.
	merge := CyMerge of: node.
	createSetExpressionBuilder ifNotNil: [
		merge onCreateSet: (createSetExpressionBuilder value: n).	
	].
	matchSetExpressionBuilder ifNotNil: [ 
		merge onMatchSet: (matchSetExpressionBuilder value: n).
	].
	query := CyQuery statements: {
		merge.
		CyReturn of: n.
	}.
	^self cypherReturnNode: query