*Neo4reSt-Pharo-Core
jsonDelete: urlString
	self accept: 'application/json'.
	self delete: urlString.
	^self response