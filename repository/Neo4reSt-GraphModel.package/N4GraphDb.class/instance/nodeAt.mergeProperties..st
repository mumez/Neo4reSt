actions-nodes
nodeAt: systemId mergeProperties: propsDict
	| n node query args |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		set: (n addAll: 'values' asCypherParameter).
	args := { 'values' -> propsDict asDictionary } asDictionary.
	^self cypherStatusOfContainUpdates: query arguments: args