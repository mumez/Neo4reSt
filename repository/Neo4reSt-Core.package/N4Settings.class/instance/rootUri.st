accessing
rootUri
	^ self at: #rootUri ifAbsentPut: [self defaultRootUri]