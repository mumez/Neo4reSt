actions
setProperties: properties relationshipAt: relId
	| props resp |
	props := N4PortableUtil default asProperties: properties.
	resp := self rawClient setProperties: props relationshipAt: relId.
	^ resp code ~= 404