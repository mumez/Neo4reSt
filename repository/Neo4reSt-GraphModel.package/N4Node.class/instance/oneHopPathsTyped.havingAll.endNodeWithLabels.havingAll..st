accessing-paths
oneHopPathsTyped: typeOrTypes havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps
	^ self db
		oneHopPathsTyped: typeOrTypes
		direction: nil
		from: self id
		havingAll: relProps
		endNodeWithLabels: labels
		havingAll: endNodeProps
		whereIn: [:start :rel :end |] returning: [ :path | path ].