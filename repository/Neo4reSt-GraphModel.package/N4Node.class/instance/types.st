accessing
types
	^ (self allRelationships collect: [:each | each type]) asSet