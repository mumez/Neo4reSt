printing
printOn: aStream
	self printElementHeaderOn: aStream.
	aStream space.
	aStream nextPut: $(.
	aStream nextPutAll: self startNodeId asString.
	aStream nextPut: $).
	aStream space.
	self direction == #in ifTrue: [aStream nextPut: $<].
	aStream nextPut: $-.
	aStream nextPutAll: self type asString.
	aStream nextPut: $-.
	self direction == #out ifTrue: [aStream nextPut: $>].
	aStream space.
	aStream nextPut: $(.
	aStream nextPutAll: self endNodeId asString.
	aStream nextPut: $).