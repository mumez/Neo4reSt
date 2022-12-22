actions-relationships
relationshipAt: systemId propertyAt: key put: value
	| s e r rel query |
	s := 's' asCypherIdentifier.
	e := 'e' asCypherIdentifier.
	r := 'r' asCypherIdentifier.
	rel := CyRelationship start: s end: e name: r. 
	query := CyQuery match: rel where: (r getId equals: systemId)
		set: {(r @ key) to: value}.
	^self cypherStatusOfContainUpdates: query params: #()