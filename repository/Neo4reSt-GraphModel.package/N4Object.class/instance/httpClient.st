accessing
httpClient

	^ httpClient ifNil: [httpClient := N4HttpClient settings: self settings]