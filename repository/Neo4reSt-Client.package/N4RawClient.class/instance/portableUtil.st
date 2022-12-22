accessing
portableUtil
	^portableUtil ifNil: [portableUtil := N4PortableUtil defaultClass new]