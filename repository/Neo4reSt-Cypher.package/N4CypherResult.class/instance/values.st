accessing
values
	self rows size > 1 ifTrue: [ ^self allValues ].
	^ self firstRowDo: [:row | row ]