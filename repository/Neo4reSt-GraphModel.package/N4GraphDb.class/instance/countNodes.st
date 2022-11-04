global operations
countNodes
	| n query resp |
	n := 'n' asCypherIdentifier.
	query := CyQuery match: n asNode.
	query addReturn: n count.
	resp := self httpClient runCypher: query.
	^(resp result data first at: 'row') first