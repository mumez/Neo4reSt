actions-nodes
mergeNodeLabeled: labelOrLabels properties: props
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n labels: labelOrLabels props: props. 
	query := CyQuery statements: {
		CyMerge of: node.
		CyReturn of: n.
	}.
	^self cypherReturnNode: query