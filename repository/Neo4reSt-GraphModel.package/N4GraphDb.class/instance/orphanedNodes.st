global operations
orphanedNodes
	| n query |
	n := 'n' asCypherIdentifier.
	query := CyQuery match: n asNode where: (n asNode -- '' asCypherIdentifier asNode) exists not return: n.
	^ self cypherReturnNodes: query