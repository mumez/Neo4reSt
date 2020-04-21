enumerating
reject: aBlock
	| ord |
	ord := OrderedCollection new.
	[self atEnd] whileFalse: [ | elem |
		(aBlock value: (elem := self next)) ifFalse: [ord add: elem]
	].
	^ord