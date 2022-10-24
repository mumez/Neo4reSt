actions-paths
existsOneHopPathsTyped: typeOrTypes direction: direction from: startNodeId havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps whereIn: whereClauseBuilder
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
		whereIn: whereClauseBuilder
		pathProcessIn: [:path | path count > 0 ]
		returnIn: [:r | r ].
	^(self httpClient runCypher: query) 
		resultDo: [ :result | result firstRowDo: [ :row | row first ] ]