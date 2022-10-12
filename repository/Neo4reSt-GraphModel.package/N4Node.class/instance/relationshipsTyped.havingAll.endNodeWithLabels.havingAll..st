accessing-relationships
relationshipsTyped: typeOrTypes havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps
	^  self relationshipsFromGraphResult: (self
		oneHopPathsTyped: typeOrTypes
		havingAll: relProps
		endNodeWithLabels: labels
		havingAll: endNodeProps)