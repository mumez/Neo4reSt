properties
propertyAt: propName put: value
	^ self restClient setProperty: propName to: value nodeAt: self id 