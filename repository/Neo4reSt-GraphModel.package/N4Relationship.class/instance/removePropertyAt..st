properties
removePropertyAt: propName
	^ self restClient deleteProperty: propName relationshipAt: self id 