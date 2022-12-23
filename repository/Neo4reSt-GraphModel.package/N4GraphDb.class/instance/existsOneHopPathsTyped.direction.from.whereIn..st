actions-paths
existsOneHopPathsTyped: typeOrTypes direction: direction from: startNodeId whereIn: whereClauseBuilder
	^ self existsOneHopPathsTyped: typeOrTypes direction: direction from: startNodeId havingAll: #() endNodeWithLabels: #() havingAll: #() whereIn: whereClauseBuilder