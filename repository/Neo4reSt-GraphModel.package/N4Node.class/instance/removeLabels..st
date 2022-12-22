actions-labels
removeLabels: labels
	| n node paramId query result |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n.
	paramId := 'id' asCypherParameter. 
	query := CyQuery match: node where: (n getId equals: paramId) remove: (n labels: labels).
	result := self db cypherStatusOfContainUpdates: query arguments: {paramId -> self id}.
	result ifTrue: [ self rawGraphObject removeLabels: labels ].
	^ result