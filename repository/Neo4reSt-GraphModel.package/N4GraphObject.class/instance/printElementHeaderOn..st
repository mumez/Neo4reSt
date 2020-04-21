printing
printElementHeaderOn: aStream
	aStream nextPutAll: self elementName.
	aStream nextPut: $[.
	aStream nextPutAll: self id printString.
	aStream nextPut: $]
	