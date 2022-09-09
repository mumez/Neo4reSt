accessing
databaseName
	databaseName ifNil: [ databaseName := self settings databaseName ].
	^ databaseName