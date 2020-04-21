*Neo4reSt-Squeak-Core
jsonPost: urlString content: jsonString
	| request |
	self initializeFromUrl: urlString urlEncoded.
	request := (self newJsonRequest initializeFromUrl: urlString urlEncoded) forSendData.
	request method: 'POST'.
	request headerAt: 'Content-Length' put: jsonString size.
	userAgent ifNotNil:[request headerAt: 'User-Agent' put: userAgent].
	^self sendRequest: request content: jsonString readStream size: jsonString size