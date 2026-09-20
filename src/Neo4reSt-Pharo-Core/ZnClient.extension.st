Extension { #name : 'ZnClient' }

{ #category : '*Neo4reSt-Pharo-Core' }
ZnClient >> contentType: aString [
	self request headers at: 'Content-Type' put: aString
]

{ #category : '*Neo4reSt-Pharo-Core' }
ZnClient >> jsonDelete: urlString [
	self accept: 'application/json'.
	self delete: urlString.
	^self response
]

{ #category : '*Neo4reSt-Pharo-Core' }
ZnClient >> jsonGet: urlString [
	self accept: 'application/json'.
	self get: urlString.
	^self response
]

{ #category : '*Neo4reSt-Pharo-Core' }
ZnClient >> jsonPost: urlString content: jsonString withStreaming: withStreamingOrNot [
	self accept: 'application/json'.
	self contentWriter: [:o | (ZnEntity with: o) contentType: 'application/json; charset=utf-8'].
	withStreamingOrNot ifTrue: [ self headerAt: 'X-Stream' put: 'true' ].
	self post: urlString contents: jsonString.
	^self response
]

{ #category : '*Neo4reSt-Pharo-Core' }
ZnClient >> jsonPost: urlString withStreaming: withStreamingOrNot [
	^self jsonPost: urlString content: '' withStreaming: withStreamingOrNot
]

{ #category : '*Neo4reSt-Pharo-Core' }
ZnClient >> jsonPut: urlString content: jsonString [
	self accept: 'application/json'.
	self contentWriter: [:o | (ZnEntity with: o) contentType: 'application/json; charset=utf-8'].
	self put: urlString contents: jsonString.
	^self response
]
