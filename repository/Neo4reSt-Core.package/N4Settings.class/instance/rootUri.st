accessing
rootUri
	^ self at: #rootUri ifAbsent: [self defaultRootUri]