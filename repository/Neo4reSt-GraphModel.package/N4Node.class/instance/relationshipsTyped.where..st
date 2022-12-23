accessing-relationships
relationshipsTyped: typeOrTypes where: where
	^ self relationshipsFromGraphResult: (self oneHopPathsTyped: typeOrTypes where: where)