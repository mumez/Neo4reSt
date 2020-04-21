accessing
rawClient

	^ rawClient ifNil: [rawClient := N4RestRawClient new]