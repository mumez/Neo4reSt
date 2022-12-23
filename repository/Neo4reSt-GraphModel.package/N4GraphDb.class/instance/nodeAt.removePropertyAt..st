actions-nodes
nodeAt: systemId removePropertyAt: key
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		remove: (n @ key).
	^self cypherStatusOfContainUpdates: query arguments: #()