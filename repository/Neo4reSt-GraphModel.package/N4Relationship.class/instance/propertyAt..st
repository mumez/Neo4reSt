properties
propertyAt: propName
	| value |
	value := self restClient getProperty: propName relationshipAt: self id.
	^ self portableUtil convertToNative: value using: self settings