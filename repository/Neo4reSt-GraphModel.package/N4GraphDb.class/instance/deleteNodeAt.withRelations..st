actions-nodes
deleteNodeAt: systemId withRelations: withRelations
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		delete: node in: [:del | del withRelations: withRelations].
	^self cypherStatusOfNodesDeleted: query