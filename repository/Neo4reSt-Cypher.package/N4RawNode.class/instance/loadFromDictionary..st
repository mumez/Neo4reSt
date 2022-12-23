loading
loadFromDictionary: aDictionary
	super loadFromDictionary: aDictionary.
	aDictionary at: 'labels' ifPresent: [:p | self labels: p].