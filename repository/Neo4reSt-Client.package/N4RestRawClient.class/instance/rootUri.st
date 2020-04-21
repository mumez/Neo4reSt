accessing
rootUri
	^ rootUri ifNil: [self rootUri: N4Settings default rootUri. rootUri]