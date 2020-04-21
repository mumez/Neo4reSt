*Neo4reSt-Squeak-Core
jsonPost: urlString
		| request |
	self initializeFromUrl: urlString.
	request := (self newJsonRequest initializeFromUrl: urlString urlEncoded) forSendData.
	request method: 'POST'.
	userAgent ifNotNil:[request headerAt: 'User-Agent' put: userAgent].
	^self sendRequest: request content: '' readStream size: 0