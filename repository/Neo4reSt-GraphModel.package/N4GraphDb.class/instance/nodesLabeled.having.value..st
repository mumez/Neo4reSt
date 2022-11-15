actions-nodes
nodesLabeled: labelOrLabels having: key value: value
	| propParam labels node query nodes |
	propParam := 'p' asCypherParameter.
	labels := labelOrLabels isArray ifTrue: [ labelOrLabels ] ifFalse: [ Array with: labelOrLabels ].
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labels)
		 where: ((node @ key) = propParam) return: node.
	nodes := OrderedCollection new.
	(self httpClient graphCypher: query params: {propParam -> value}) resultDo: [ :r |
		 r allGraphsDo: [:g | nodes add: g node]
	].
	^ nodes