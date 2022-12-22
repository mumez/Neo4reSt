accessing-paths
outOneHopPathsTyped: typeOrTypes where: where
	^ self db
		oneHopPathsTyped: typeOrTypes
		direction: #out
		from: self id
		havingAll: {}
		endNodeWithLabels: {}
		havingAll: {}
		whereIn: where