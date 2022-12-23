accessing-relationships
inRelationshipsTyped: typeOrTypes havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps
	^ self inRelationshipsFromGraphResult: (self
		inOneHopPathsTyped: typeOrTypes
		havingAll: relProps
		endNodeWithLabels: labels
		havingAll: endNodeProps)