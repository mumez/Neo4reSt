actions-nodes
nodeAt: systemId mergeProperties: argsDict
	| n node query arguments |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		set: (n addAll: 'values' asCypherParameter).
	arguments := { 'values' -> argsDict asDictionary } asDictionary.
	^(self statsCypher: query params: arguments)
		resultDo: [:r | r containsUpdates ]