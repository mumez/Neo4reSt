*Neo4reSt-Pharo-Core
jsonPut: urlString content: jsonString
	self accept: 'application/json'.
	self contentWriter: [:o | (ZnEntity with: o) contentType: 'application/json; charset=utf-8'].
	self put: urlString contents: jsonString.
	^self response