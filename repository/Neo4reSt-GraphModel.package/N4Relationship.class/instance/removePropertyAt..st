properties
removePropertyAt: propName
	^ self httpClient deleteProperty: propName relationshipAt: self id 