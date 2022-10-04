properties
propertyAt: propName put: value
	| result |
	result := self db nodeAt: self id propertyAt: propName put: value.
	result ifTrue: [ self rawGraphObject propertyAt: propName put: value ].
	^result 