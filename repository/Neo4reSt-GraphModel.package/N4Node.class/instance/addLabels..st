actions-labels
addLabels: labels
	| n node paramId query result |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n.
	paramId := 'id' asCypherParameter. 
	query := CyQuery match: node where: (n getId equals: paramId) set: (n labels: labels).
	result := self db cypherStatusOfContainUpdates: query arguments: {paramId -> self id}.
	result ifTrue: [ self rawGraphObject addLabels: labels ].
	^ result