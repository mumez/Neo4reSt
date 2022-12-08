cypher-convenience
cypherReturnNodes: query
	| nodes |
	nodes := OrderedCollection new.
	(self httpClient graphCypher: query) resultDo: [ :r |
		 r allGraphsDo: [:g | nodes add: (self nodeClass on: g node from: self)]
	].
	^ nodes