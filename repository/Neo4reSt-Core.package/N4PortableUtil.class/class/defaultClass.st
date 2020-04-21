instance creation
defaultClass
	ActualClass ifNil: [ActualClass := ((N4PortableUtil subclasses at: 1) activate)].
	^ ActualClass