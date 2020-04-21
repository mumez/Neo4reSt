read/write
readJsonFrom: aStream
	^ (NeoJSONReader on: aStream) next