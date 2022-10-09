actions-relationships
relationshipAt: systemId removePropertyAt: key
	| s e r rel query |
	s := 's' asCypherIdentifier.
	e := 'e' asCypherIdentifier.
	r := 'r' asCypherIdentifier.
	rel := CyRelationship start: s end: e name: r. 
	query := CyQuery match: rel where: (r getId equals: systemId)
		remove: (r @ key).
	^self cypherStatusOfContainUpdates: query params: #()