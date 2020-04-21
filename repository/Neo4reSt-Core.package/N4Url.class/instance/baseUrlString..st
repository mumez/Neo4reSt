accessing
baseUrlString: anObject
	| string |
	anObject ifNil: [^baseUrlString := nil].
	string := anObject last = $/ ifTrue: [anObject] ifFalse: [anObject, '/'].
	baseUrlString := string