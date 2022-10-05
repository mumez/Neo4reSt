properties
mergeProperties: propAssocs
	| result |
	result := self db nodeAt: self id mergeProperties: propAssocs.
	result ifTrue: [ self rawGraphObject mergeProperties: propAssocs ].
	^result 