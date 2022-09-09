properties
propertyAt: propName put: value
	^ self httpClient setProperty: propName to: value nodeAt: self id 