global operations
countRelationships
	| r query resp |
	r := 'r' asCypherIdentifier.
	query := CyQuery match: ('' asCypherIdentifier asNode - r asRelationship - '' asCypherIdentifier asNode).
	(query addReturn: (r id count) beDistinct).
	resp := self httpClient runCypher: query.
	^ resp resultDo: [:result | result firstRowDo: [:row | row first]].
	