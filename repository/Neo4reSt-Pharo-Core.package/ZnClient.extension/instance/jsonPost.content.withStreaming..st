*Neo4reSt-Pharo-Core
jsonPost: urlString content: jsonString withStreaming: withStreamingOrNot
	self accept: 'application/json'.
	self contentWriter: [:o | (ZnEntity with: o) contentType: 'application/json; charset=utf-8'].
	withStreamingOrNot ifTrue: [ self headerAt: 'X-Stream' put: 'true' ].
	self post: urlString contents: jsonString.
	^self response