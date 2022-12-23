private
firstOrAllOf: aCollection
	aCollection size <= 1 ifTrue: [ ^ self firstOrNilOf: aCollection ].
	^ aCollection 