Extension { #name : #WebClient }

{ #category : #'*Neo4reSt-Squeak-Core' }
WebClient >> jsonDelete: urlString [
		| request |
	self initializeFromUrl: urlString urlEncoded.
	request := self newJsonRequest initializeFromUrl: urlString urlEncoded.
	request method: 'DELETE'.
	userAgent ifNotNil:[request headerAt: 'User-Agent' put: userAgent].
	^self sendRequest: request
]

{ #category : #'*Neo4reSt-Squeak-Core' }
WebClient >> jsonGet: urlString [
	| request |
	self initializeFromUrl: urlString.
	request := self newJsonRequest initializeFromUrl: urlString urlEncoded.
	request method: 'GET'.
	userAgent ifNotNil:[request headerAt: 'User-Agent' put: userAgent].
	^self sendRequest: request

]

{ #category : #'*Neo4reSt-Squeak-Core' }
WebClient >> jsonPost: urlString [
		| request |
	self initializeFromUrl: urlString.
	request := (self newJsonRequest initializeFromUrl: urlString urlEncoded) forSendData.
	request method: 'POST'.
	userAgent ifNotNil:[request headerAt: 'User-Agent' put: userAgent].
	^self sendRequest: request content: '' readStream size: 0
]

{ #category : #'*Neo4reSt-Squeak-Core' }
WebClient >> jsonPost: urlString content: jsonString [
	| request |
	self initializeFromUrl: urlString urlEncoded.
	request := (self newJsonRequest initializeFromUrl: urlString urlEncoded) forSendData.
	request method: 'POST'.
	request headerAt: 'Content-Length' put: jsonString size.
	userAgent ifNotNil:[request headerAt: 'User-Agent' put: userAgent].
	^self sendRequest: request content: jsonString readStream size: jsonString size
]

{ #category : #'*Neo4reSt-Squeak-Core' }
WebClient >> jsonPut: urlString content: jsonString [
	| request |
	self initializeFromUrl: urlString urlEncoded.
	request := (self newJsonRequest initializeFromUrl: urlString urlEncoded) forSendData.
	request method: 'PUT'.
	request headerAt: 'Content-Length' put: jsonString size.
	userAgent ifNotNil:[request headerAt: 'User-Agent' put: userAgent].
	^self sendRequest: request content: jsonString readStream size: jsonString size
]

{ #category : #'*Neo4reSt-Squeak-Core' }
WebClient >> newJsonRequest [
	^ N4WebJsonRequest new
]
