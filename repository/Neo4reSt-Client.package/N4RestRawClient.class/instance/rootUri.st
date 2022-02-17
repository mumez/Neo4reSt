accessing
rootUri
	rootUri ifNil: [self rootUri: self settings rootUri].
	^rootUri 