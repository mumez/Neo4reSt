releasing
releaseHttpClient
	httpClient ifNotNil: [httpClient close].
	httpClient := nil
