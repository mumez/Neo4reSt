defaults
defaultRootUri
	self supportV4 ifTrue: [ ^'http://localhost:7474/' ].
	^'http://localhost:7474/db/data/'