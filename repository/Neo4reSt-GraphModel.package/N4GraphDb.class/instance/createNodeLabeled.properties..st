actions-nodes
createNodeLabeled: labelOrLabels properties: props
	| labels n node query |
	labels := labelOrLabels isArray ifTrue: [ labelOrLabels ] ifFalse: [ Array with: labelOrLabels ].
	n := 'n' asCypherIdentifier.
	node := CyNode name: n labels: labels props: props. 
	query := CyQuery statements: {
		CyCreate of: node.
		CyReturn of: n.
	}.
	^self cypherReturnNode: query