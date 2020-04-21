accessing
firstOrNil
	self isEmpty ifTrue: [^nil].
	^ self first