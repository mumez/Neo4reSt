properties
removePropertyAt: propName
	^ self restClient deleteProperty: propName nodeAt: self id 