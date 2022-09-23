actions-nodes
nodesLabeled: labelOrLabels where: whereClauseBuilder
	| labels node query |
	labels := labelOrLabels isArray ifTrue: [ labelOrLabels ] ifFalse: [ Array with: labelOrLabels ].
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labels)
		 where: (whereClauseBuilder value: node) return: node.
	^(self httpClient graphCypher: query) resultDo: [ :r | r firstGraphDo: [ :g | g nodes] ifNone: [ #() ] ]