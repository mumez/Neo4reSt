actions-nodes
nodeAt: systemId mergeProperties: propsDict
	| n node query params |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		set: (n addAll: 'values' asCypherParameter).
	params := { 'values' -> propsDict asDictionary } asDictionary.
	^self cypherStatusOfContainUpdates: query params: params