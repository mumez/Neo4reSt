*Neo4reSt-Pharo-Core
jsonGet: urlString
	self accept: 'application/json'.
	self get: urlString.
	^self response