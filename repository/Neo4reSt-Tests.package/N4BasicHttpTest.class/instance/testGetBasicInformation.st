testing
testGetBasicInformation
	| client info |
	client := self newHttpClient.
	info := client getBasicInformation.
	self assert: (info includesKey: 'neo4j_version')