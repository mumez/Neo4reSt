global operations
countRelationshipsTyped: typeOrTypes
	| r types rel query resp |
	r := 'r' asCypherIdentifier.
	types := typeOrTypes isArray ifTrue: [ typeOrTypes ] ifFalse:[Array with: typeOrTypes].
	rel := r asRelationship types: types.
	query := CyQuery match: ('' asCypherIdentifier asNode - (rel) - '' asCypherIdentifier asNode).
	(query addReturn: (r id count) beDistinct).
	resp := self httpClient runCypher: query.
	^ resp resultDo: [:result | result firstRowDo: [:row | row first]].