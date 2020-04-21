accessing
rootUri: anObject
	anObject isNil ifTrue: [^rootUri := nil].
	rootUri := N4Url baseUrlString: anObject