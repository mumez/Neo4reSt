actions-relationships
deleteRelationshipAt: systemId
	| s e r rel query |
	s := 's' asCypherIdentifier.
	e := 'e' asCypherIdentifier.
	r := 'r' asCypherIdentifier.
	rel := CyRelationship start: s end: e name: r. 
	query := CyQuery match: rel where: (r getId equals: systemId) delete: r.
	^(self statsCypher: query) resultDo: [:result | result relationshipDeleted > 0]