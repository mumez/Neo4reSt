actions-nodes
nodesLabeled: labelOrLabels where: whereClauseBuilder skip: skip limit: limit
	| node query nodes |
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labelOrLabels)
		 where: (whereClauseBuilder value: node) return: node skip: skip limit: limit.
	nodes := OrderedCollection new.
	(self httpClient graphCypher: query) resultDo: [ :r |
		 r allGraphsDo: [:g | nodes add: g node]
	].
	^ nodes