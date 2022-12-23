builder
newCypher: queryString params: dictionary
	^self newCypher: queryString params: dictionary resultDataContents: nil includeStats: nil