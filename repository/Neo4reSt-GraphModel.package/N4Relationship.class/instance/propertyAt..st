properties
propertyAt: propName
	| value |
	value := self httpClient getProperty: propName relationshipAt: self id.
	^ self portableUtil convertToNative: value using: self settings