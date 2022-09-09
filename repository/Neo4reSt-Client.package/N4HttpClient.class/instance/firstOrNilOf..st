private
firstOrNilOf: aCollection
	aCollection isEmpty ifTrue: [^nil].
	^ aCollection first