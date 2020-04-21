actions
createNode: properties
	| props |
	props := N4PortableUtil default asProperties: properties.
	^self rawClient createNode: props