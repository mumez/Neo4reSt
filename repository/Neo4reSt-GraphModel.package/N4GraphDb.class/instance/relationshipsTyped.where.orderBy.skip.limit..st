actions-relationships
relationshipsTyped: typeOrTypes where: whereClauseBuilder orderBy: orderByClause skip: skip limit: limit
	| r rel query relationships |
	r := 'r' asCypherIdentifier.
	rel := r rel: typeOrTypes props: #().
	query := CyQuery match: ('' asCypherIdentifier asNode - (rel) -> '' asCypherIdentifier asNode)
		 where: (whereClauseBuilder value: r) return: r orderBy: orderByClause skip: skip limit: limit.
	relationships := OrderedCollection new.
	(self httpClient graphCypher: query) resultDo: [ :result |
		 result allGraphsDo: [:g | relationships add: (self relationshipClass on: g relationship beOut from: self)]
	].
	^ relationships