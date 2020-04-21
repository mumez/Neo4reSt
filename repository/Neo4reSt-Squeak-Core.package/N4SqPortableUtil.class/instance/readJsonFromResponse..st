actions
readJsonFromResponse: httpResponse
	| strm |
	"strm := (httpResponse headerAt: 'transfer-encoding') = 'chunked' ifTrue: [httpResponse content readStream] ifFalse: [httpResponse contentStream]."
	strm := httpResponse content readStream.
	^ self readJsonFrom: strm