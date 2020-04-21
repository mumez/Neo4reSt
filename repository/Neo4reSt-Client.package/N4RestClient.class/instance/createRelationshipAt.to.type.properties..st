actions
createRelationshipAt: nodeId to: uri type: type properties: properties
	| props |
	props := N4PortableUtil default asProperties: properties.
	^self rawClient createRelationshipAt: nodeId to: uri type: type properties: props