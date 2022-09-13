actions
resultDo: aBlock
	self signalIfError.
	^ aBlock value: self result