actions-labels
addLabels: labels
	| n node paramId query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n.
	paramId := 'id' asCypherParameter. 
	query := CyQuery match: node where: (n getId equals: paramId) set: (n labels: labels).
	^ self db cypherStatusOfContainUpdates: query params: {paramId -> self id}