global operations
allLabels
	| n query labels label resp |
	n := 'n' asCypherIdentifier.
	query := CyQuery match: (n asNode).
	labels := 'labels' asCypherIdentifier.
	(query addWith: (n labels as: labels)) beDistinct.
	label := 'label' asCypherIdentifier.
	query addUnwind: (labels deepCopy as: label).
	(query addReturn: label) beDistinct.

	resp := self httpClient runCypher: query.
	^self firstFieldValuesOf: resp