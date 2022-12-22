accessing-relationships
inRelationshipsTyped: typeOrTypes where: where
	^ self inRelationshipsFromGraphResult: (self inOneHopPathsTyped: typeOrTypes where: where)