accessing
rawClient

	^ rawClient ifNil: [rawClient := N4RawClient new]