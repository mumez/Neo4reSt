properties
propertyAt: propName put: value
	^ self restClient setProperty: propName to: value relationshipAt: self id 