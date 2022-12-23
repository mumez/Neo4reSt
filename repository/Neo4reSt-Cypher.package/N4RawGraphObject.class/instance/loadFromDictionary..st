loading
loadFromDictionary: aDictionary
	aDictionary at: 'id' ifPresent: [:p | self id: p asInteger].
	aDictionary at: 'properties' ifPresent: [:p | self properties: p].