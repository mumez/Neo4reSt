actions-http-helper
createHttpClient
	| cli |
	cli := ZnClient new.
	self settings keepConnection ifFalse: [ cli beOneShot ].
	^cli