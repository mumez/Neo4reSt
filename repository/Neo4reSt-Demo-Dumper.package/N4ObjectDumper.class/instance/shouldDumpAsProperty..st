testing
shouldDumpAsProperty: anObject
	anObject isString ifTrue: [^true].
	anObject isNumber ifTrue: [^true].
	anObject isNil ifTrue: [^true].
	anObject == true ifTrue: [^true].
	anObject == false ifTrue: [^true].
	
	^false
	