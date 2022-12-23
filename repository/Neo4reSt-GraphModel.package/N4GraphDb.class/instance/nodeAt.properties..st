actions-nodes
nodeAt: systemId properties: propsDict
	| n node query args |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		set: (n to: 'values' asCypherParameter).
	args := { 'values' -> propsDict asDictionary } asDictionary.
	^self cypherStatusOfContainUpdates: query arguments: args