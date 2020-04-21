enumerating
select: aBlock
	| ord |
	ord := OrderedCollection new.
	[self atEnd] whileFalse: [ | elem |
		(aBlock value: (elem := self next)) ifTrue: [ord add: elem]
	].
	^ord