properties
removePropertyAt: propName
	| result |
	result := self db nodeAt: self id removePropertyAt: propName.
	result ifTrue: [ self rawGraphObject removePropertyAt: propName ].
	^ result 