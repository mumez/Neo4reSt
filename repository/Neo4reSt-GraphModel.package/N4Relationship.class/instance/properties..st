properties
properties: propAssocs
	| result |
	result := self db relationshipAt: self id properties: propAssocs.
	result ifTrue: [ self rawGraphObject properties: propAssocs ].
	^ result 