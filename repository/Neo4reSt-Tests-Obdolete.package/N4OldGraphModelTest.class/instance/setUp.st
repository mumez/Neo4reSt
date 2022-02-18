running
setUp
	| initialNode |
	db := N4GraphDb new.
	[initialNode := db initialNode] on: Error do: [:ex |
		self error: 'Neo4j is running? ', ex description printString].

	(initialNode outgoing: 'N4GraphModelTest') do: [:each | each delete].

	initialNodeForTest := initialNode relateToNewNode: 'N4GraphModelTest'
	
