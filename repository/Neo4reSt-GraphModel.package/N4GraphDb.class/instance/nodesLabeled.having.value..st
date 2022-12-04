actions-nodes
nodesLabeled: labelOrLabels having: key value: value
	| propParam node query nodes |
	propParam := 'p' asCypherParameter.
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labelOrLabels)
		 where: ((node @ key) = propParam) return: node.
	nodes := OrderedCollection new.
	(self httpClient graphCypher: query params: {propParam -> value}) resultDo: [ :r |
		 r allGraphsDo: [:g | nodes add: g node]
	].
	^ nodes