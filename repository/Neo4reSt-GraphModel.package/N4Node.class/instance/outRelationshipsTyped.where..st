accessing-relationships
outRelationshipsTyped: typeOrTypes where: where
	^  self outRelationshipsFromGraphResult: (self outOneHopPathsTyped: typeOrTypes where: where)