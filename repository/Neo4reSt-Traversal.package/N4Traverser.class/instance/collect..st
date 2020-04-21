enumerating
collect: aBlock
	| ord |
	ord := OrderedCollection new: self json size.
	[self atEnd] whileFalse: [
		ord add: (aBlock value: self next)
	].
	^ord