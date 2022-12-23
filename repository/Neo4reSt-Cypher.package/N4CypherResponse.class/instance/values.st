accessing-results
values
	self results size > 1 ifTrue: [ 
		^ self resultsDo: [ :result | result values ] ].
	^ self resultDo: [ :result | result values ]