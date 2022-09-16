actions-nodes
nodesLabeled: labelOrLabels where: whereClauseBuilder skip: skip limit: limit
	| labels node query nodes |
	labels := labelOrLabels isArray ifTrue: [ labelOrLabels ] ifFalse: [ Array with: labelOrLabels ].
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labels)
		 where: (whereClauseBuilder value: node) return: node skip: skip limit: limit.
	nodes := OrderedCollection new.
	(self graphCypher: query) resultDo: [ :r |
		 r allGraphsDo: [:g | nodes add: g node]
	].
	^ nodes