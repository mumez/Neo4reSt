actions-relationships
relationshipAt: systemId properties: argsDict
	| s e r rel query arguments |
	s := 's' asCypherIdentifier.
	e := 'e' asCypherIdentifier.
	r := 'r' asCypherIdentifier.
	rel := CyRelationship start: s end: e name: r. 
	query := CyQuery match: rel where: (r getId equals: systemId)
		set: (r to: 'values' asCypherParameter).
	arguments := { 'values' -> argsDict asDictionary } asDictionary.
	^(self statsCypher: query params: arguments)
		resultDo: [:result | result containsUpdates ]