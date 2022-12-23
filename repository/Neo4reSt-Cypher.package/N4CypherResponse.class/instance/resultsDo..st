actions
resultsDo: aBlock
	self signalIfError.
	^ self results collect: aBlock