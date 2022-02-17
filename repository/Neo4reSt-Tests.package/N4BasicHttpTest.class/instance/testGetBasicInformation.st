testing
testGetBasicInformation
	| client info |
	client := N4RestClient settings: N4Settings default.
	info := client getBasicInformation.
	self assert: (info includesKey: 'neo4j_version')