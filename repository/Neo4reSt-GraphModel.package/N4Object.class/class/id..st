instance creation
id: anInteger 
	| inst |
	inst := self new.
	inst id: anInteger asInteger.
	^inst