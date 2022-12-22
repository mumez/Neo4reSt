printing
printElementHeaderOn: aStream
	aStream nextPutAll: self elementName.
	aStream nextPut: $[.
	self httpClient rootUri printOn: aStream.
	aStream nextPut: $]
	