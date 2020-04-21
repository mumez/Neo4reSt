accessing
ensuredHttpClient
	(httpClient notNil and: [httpClient isConnected not]) ifTrue: [self releaseHttpClient].
	httpClient ifNil: [httpClient := self createHttpClient].
	^httpClient
	