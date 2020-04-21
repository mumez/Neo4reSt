actions
setProperty: propName to: value nodeAt: nodeId 
	| resp |
	resp := self rawClient setProperty: propName to: value nodeAt: nodeId.
	^ resp code ~= 404