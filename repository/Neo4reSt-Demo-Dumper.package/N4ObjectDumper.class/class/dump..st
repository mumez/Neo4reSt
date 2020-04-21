actions
dump: anObject
	| inst |
	inst := self on: N4GraphDb new.
	inst dump: anObject.	
	^inst