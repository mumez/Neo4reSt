accessing
databaseName
	^ self at: #databaseName ifAbsentPut: ['neo4j']