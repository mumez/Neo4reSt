actions-nodes
nodeAt: systemId mergeProperties: argsDict
	| n node query arguments |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		set: (n addAll: 'values' asCypherParameter).
	arguments := { 'values' -> argsDict asDictionary } asDictionary.
	^(self runCypher: query params: arguments format: nil stats: true)
		resultDo: [:r | r containsUpdates ]