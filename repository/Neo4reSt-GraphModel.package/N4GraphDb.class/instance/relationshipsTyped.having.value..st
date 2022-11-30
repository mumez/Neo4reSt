actions-relationships
relationshipsTyped: typeOrTypes having: key value: value
	| propParam r rel query relationships |
	propParam := 'p' asCypherParameter.
	r := 'r' asCypherIdentifier.
	rel := r rel: typeOrTypes props: #().
	query := CyQuery match: ('' asCypherIdentifier asNode - (rel) -> '' asCypherIdentifier asNode)
		 where: ((r @ key) = propParam) return: r.
	relationships := OrderedCollection new.
	(self httpClient graphCypher: query params: {propParam -> value}) resultDo: [ :result |
		 result allGraphsDo: [:g | relationships add: g relationship beOut]
	].
	^ relationships