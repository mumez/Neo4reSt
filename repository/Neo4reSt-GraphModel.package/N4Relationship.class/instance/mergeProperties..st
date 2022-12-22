properties
mergeProperties: propAssocs
	| result |
	result := self db relationshipAt: self id mergeProperties: propAssocs.
	result ifTrue: [ self rawGraphObject mergeProperties: propAssocs ].
	^ result 