accessing-relationships
outRelationshipsTyped: typeOrTypes havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps
	^  self outRelationshipsFromGraphResult: (self
		outOneHopPathsTyped: typeOrTypes
		havingAll: relProps
		endNodeWithLabels: labels
		havingAll: endNodeProps)