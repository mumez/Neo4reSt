global operations
countNodesLabeled: labelOrLabels
	| n node query resp |
	n := 'n' asCypherIdentifier.
	node := n asNode.
	labelOrLabels ifNotNil: [ 
		node labels: (labelOrLabels isString ifTrue: [{labelOrLabels}] ifFalse: [labelOrLabels]). 
	].
	query := CyQuery match: node.
	query addReturn: n count.
	resp := self httpClient runCypher: query.
	^(resp result data first at: 'row') first