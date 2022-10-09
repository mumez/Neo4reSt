properties
removePropertyAt: propName
	| result |
	result := self db relationshipAt: self id removePropertyAt: propName.
	result ifTrue: [ self rawGraphObject removePropertyAt: propName ].
	^ result 