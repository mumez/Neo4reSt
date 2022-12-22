loading
loadFromDictionary: aDictionary
	super loadFromDictionary: aDictionary.
	aDictionary at: 'type' ifPresent: [:p | self type: p].
	aDictionary at: 'startNode' ifPresent: [:p | self startNodeId: p].
	aDictionary at: 'endNode' ifPresent: [:p | self endNodeId: p].