printing
printElementHeaderOn: aStream
	aStream nextPutAll: self elementName.
	aStream nextPut: $[.
	self restClient rootUri printOn: aStream.
	aStream nextPut: $]
	