accessing
httpClient
	^  N4Settings default keepConnection
		ifTrue: [self ensuredHttpClient]
		ifFalse: [self createHttpClient]