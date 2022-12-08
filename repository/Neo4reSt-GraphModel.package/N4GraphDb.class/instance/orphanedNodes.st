global operations
orphanedNodes
	| n query nodes |
	n := 'n' asCypherIdentifier.
	query := CyQuery match: n asNode where: (n asNode -- '' asCypherIdentifier asNode) exists not return: n.
	nodes := OrderedCollection new.
	(self httpClient graphCypher: query) resultDo: [ :r |
		 r allGraphsDo: [:g | nodes add: g node]
	].
	^ nodes