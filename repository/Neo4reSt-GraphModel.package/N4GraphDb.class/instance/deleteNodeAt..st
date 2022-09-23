actions-nodes
deleteNodeAt: systemId
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		delete: node.
	^self cypherStatusOfNodesDeleted: query