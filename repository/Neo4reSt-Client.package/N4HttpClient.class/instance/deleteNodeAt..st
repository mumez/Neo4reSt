actions-nodes
deleteNodeAt: systemId
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		delete: node.
	^(self statsCypher: query) resultDo: [:r | r nodesDeleted > 0]