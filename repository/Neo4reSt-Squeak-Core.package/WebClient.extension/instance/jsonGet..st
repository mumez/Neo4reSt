*Neo4reSt-Squeak-Core
jsonGet: urlString
	| request |
	self initializeFromUrl: urlString.
	request := self newJsonRequest initializeFromUrl: urlString urlEncoded.
	request method: 'GET'.
	userAgent ifNotNil:[request headerAt: 'User-Agent' put: userAgent].
	^self sendRequest: request
