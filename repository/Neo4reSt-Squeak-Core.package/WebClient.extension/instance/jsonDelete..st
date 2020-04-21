*Neo4reSt-Squeak-Core
jsonDelete: urlString
		| request |
	self initializeFromUrl: urlString urlEncoded.
	request := self newJsonRequest initializeFromUrl: urlString urlEncoded.
	request method: 'DELETE'.
	userAgent ifNotNil:[request headerAt: 'User-Agent' put: userAgent].
	^self sendRequest: request