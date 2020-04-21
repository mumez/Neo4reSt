enumerating
detect: aBlock ifNone: noneBlock
	[self atEnd] whileFalse: [ | elem |
		(aBlock value: (elem := self next)) ifTrue: [^elem]
	].
	^noneBlock value