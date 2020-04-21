properties
propertyAt: propName
	| value |
	value := self restClient getProperty: propName nodeAt: self id.
	^ self portableUtil convertToNative: value using: self settings

