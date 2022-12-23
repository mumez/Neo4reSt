accessing-paths
inOneHopPathsTyped: typeOrTypes havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps
	^ self db
		oneHopPathsTyped: typeOrTypes
		direction: #in
		from: self id
		havingAll: relProps
		endNodeWithLabels: labels
		havingAll: endNodeProps
		whereIn: [:start :rel :end |]