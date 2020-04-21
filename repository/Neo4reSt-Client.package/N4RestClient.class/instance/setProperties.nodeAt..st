actions
setProperties: properties nodeAt: nodeId
	| props resp |
	props := N4PortableUtil default asProperties: properties.
	resp := self rawClient setProperties: props nodeAt: nodeId.
	^ resp code ~= 404