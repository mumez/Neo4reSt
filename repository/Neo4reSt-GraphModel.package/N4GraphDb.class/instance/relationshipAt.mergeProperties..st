actions-relationships
relationshipAt: systemId mergeProperties: propsDict
	| s e r rel query args |
	s := 's' asCypherIdentifier.
	e := 'e' asCypherIdentifier.
	r := 'r' asCypherIdentifier.
	rel := CyRelationship start: s end: e name: r. 
	query := CyQuery match: rel where: (r getId equals: systemId)
		set: (r addAll: 'values' asCypherParameter).	
	args := { 'values' -> propsDict asDictionary } asDictionary.
	^self cypherStatusOfContainUpdates: query arguments: args