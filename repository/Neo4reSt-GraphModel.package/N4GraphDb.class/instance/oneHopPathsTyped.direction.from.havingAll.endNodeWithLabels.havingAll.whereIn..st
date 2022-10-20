actions-paths
oneHopPathsTyped: typeOrTypes direction: direction from: startNodeId havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps whereIn: whereClauseBuilder
	^ self oneHopPathsTyped: typeOrTypes direction: direction from: startNodeId havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps whereIn: whereClauseBuilder returnIn: nil returning: [:path | path]