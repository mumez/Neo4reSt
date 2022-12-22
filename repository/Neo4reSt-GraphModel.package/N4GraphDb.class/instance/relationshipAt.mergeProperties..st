actions-relationships
relationshipAt: systemId mergeProperties: propsDict
	| s e r rel query params |
	s := 's' asCypherIdentifier.
	e := 'e' asCypherIdentifier.
	r := 'r' asCypherIdentifier.
	rel := CyRelationship start: s end: e name: r. 
	query := CyQuery match: rel where: (r getId equals: systemId)
		set: (r addAll: 'values' asCypherParameter).	
	params := { 'values' -> propsDict asDictionary } asDictionary.
	^self cypherStatusOfContainUpdates: query params: params