accessing-results
values
	self results size > 1 ifTrue: [ ^self allValues ].
	^self resultDo: [:result | result values]