actions-relationships
deleteRelationshipsTyped: typeOrTypes havingAll: propertiesArray
	| r rel query |
	r := 'r' asCypherIdentifier.
	rel := r rel: typeOrTypes props: propertiesArray.
	query := CyQuery match: ('' asCypherIdentifier asNode - (rel) - '' asCypherIdentifier asNode).
	query addDelete: r.
	^self cypherStatusOfRelationshipDeleted: query