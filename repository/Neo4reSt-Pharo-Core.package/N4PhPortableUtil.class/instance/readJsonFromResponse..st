actions
readJsonFromResponse: httpResponse
	| strm |
	strm := httpResponse contents readStream.
	^ self readJsonFrom: strm