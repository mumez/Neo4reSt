initialize
readFrom: aStream
	"Parse an HTTP response from the given stream"
	
	| space |
	stream := aStream.
	stream upToAll: 'HTTP/'.
	space := Character space.
	protocol := 'HTTP/', (stream upTo: space).
	code := [(stream upTo: space) asNumber] on: Error do: [^ self error:'Invalid response: ', stream upToEnd].
	status := code printString, ' ', (stream upToAll: String crlf).
	
	headers := WebUtils readHeadersFrom: stream.
