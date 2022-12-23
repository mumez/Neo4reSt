global operations
allRelationshipTypes
	| r query resp |
	r := 'r' asCypherIdentifier.
	query := CyQuery match: ('' asCypherIdentifier asNode - r asRelationship - '' asCypherIdentifier asNode).
	(query addReturn: r type) beDistinct.
	resp := self httpClient runCypher: query.
	^self firstFieldValuesOf: resp