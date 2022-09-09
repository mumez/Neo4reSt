properties
propertyAt: propName
	| value |
	value := self httpClient getProperty: propName nodeAt: self id.
	^ self portableUtil convertToNative: value using: self settings

