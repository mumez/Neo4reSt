actions-nodes
nodeAt: systemId propertyAt: key put: value
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		set: {(n @ key) to: value}.
	^self cypherStatusOfContainUpdates: query params: #()