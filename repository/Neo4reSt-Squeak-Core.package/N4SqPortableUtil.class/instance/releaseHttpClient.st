releasing
releaseHttpClient
	httpClient ifNotNil: [httpClient destroy].
	httpClient := nil