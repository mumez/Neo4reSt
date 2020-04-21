accessing
error
	self errors isEmptyOrNil ifTrue: [^nil].
	^ self errors at: 1