accessing-paths
oneHopPathsTyped: typeOrTypes where: where
	^ self db
		oneHopPathsTyped: typeOrTypes
		direction: nil
		from: self id
		havingAll: {}
		endNodeWithLabels: {}
		havingAll: {}
		whereIn: where