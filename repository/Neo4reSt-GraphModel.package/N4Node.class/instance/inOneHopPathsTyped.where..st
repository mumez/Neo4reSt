accessing-paths
inOneHopPathsTyped: typeOrTypes where: where
	^ self db
		oneHopPathsTyped: typeOrTypes
		direction: #in
		from: self id
		havingAll: {}
		endNodeWithLabels: {}
		havingAll: {}
		whereIn: where