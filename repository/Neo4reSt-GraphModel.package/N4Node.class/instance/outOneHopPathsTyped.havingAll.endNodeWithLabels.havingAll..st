accessing-paths
outOneHopPathsTyped: typeOrTypes havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps
	^ self db
		oneHopPathsTyped: typeOrTypes
		direction: #out
		from: self id
		havingAll: relProps
		endNodeWithLabels: labels
		havingAll: endNodeProps
		whereIn: [:start :rel :end |]