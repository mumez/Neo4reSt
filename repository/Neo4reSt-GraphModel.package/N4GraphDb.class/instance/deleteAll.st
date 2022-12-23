global operations
deleteAll
	| n query |
	n := 'n' asCypherIdentifier.
	query := CyQuery match: n asNode.
	(query addDelete: n) withRelations: true.
	^self cypherStatusOfNodesDeleted: query