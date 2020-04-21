accessing
result
	self results isEmptyOrNil ifTrue: [^nil].
	^ self results at: 1