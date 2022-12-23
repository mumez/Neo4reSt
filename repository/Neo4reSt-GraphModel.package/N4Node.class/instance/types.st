accessing
types
	^ (self relationships collect: [:each | each type]) asSet