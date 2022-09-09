properties
removePropertyAt: propName
	^ self httpClient deleteProperty: propName nodeAt: self id 