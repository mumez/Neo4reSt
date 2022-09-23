actions-nodes
nodeAt: systemId
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		return: node.
	^self cypherReturnNode: query