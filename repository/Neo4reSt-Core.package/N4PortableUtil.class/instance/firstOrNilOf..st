actions
firstOrNilOf: aCollection
	aCollection isEmpty ifTrue: [^nil].
	^ aCollection first