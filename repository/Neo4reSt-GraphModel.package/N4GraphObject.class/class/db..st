instance creation
db: aGraphDb
	| inst |
	inst := self new.
	inst db: aGraphDb.
	^inst