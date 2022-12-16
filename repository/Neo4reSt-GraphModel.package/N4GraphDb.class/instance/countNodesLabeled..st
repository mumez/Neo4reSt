actions-nodes
countNodesLabeled: labelOrLabels
	| n node query resp |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n labels: labelOrLabels.
	query := CyQuery match: node.
	query addReturn: n count.
	resp := self httpClient runCypher: query.
	^ resp resultDo: [:result | result firstRowDo: [:row | row first]].