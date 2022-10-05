properties
properties: propAssocs
	| result |
	result := self db nodeAt: self id properties: propAssocs.
	result ifTrue: [ self rawGraphObject properties: propAssocs ].
	^result 