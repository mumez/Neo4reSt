printing
printOn: aStream
	self printElementHeaderOn: aStream.
	self labels ifEmpty: [ ^self ].
	aStream nextPutAll: self labels printString.
	