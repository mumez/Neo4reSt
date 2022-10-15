actions-paths
oneHopPathsTyped: typeOrTypes direction: direction from: startNodeId havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps whereIn: whereClauseBuilder returning: returner
	| pathBlock query |
	pathBlock := [ :startNode :rel :endNode | startNode - rel - endNode ].
	direction == #in ifTrue: [ pathBlock := [ :startNode :rel :endNode | startNode <- rel - endNode ]].
	direction == #out ifTrue: [ pathBlock := [ :startNode :rel :endNode | startNode - rel -> endNode ]].
	
	query := CyQuery
		matchPathWithRelationshipsOfTypes: typeOrTypes
		havingAll: relProps
		fromNodeAt: startNodeId
		endNodeIn: [ :e | e node: labels props: endNodeProps ]
		pathIn: pathBlock
		whereIn: whereClauseBuilder.
	^(self httpClient graphCypher: query) resultDo: [ :result | returner value: result ]