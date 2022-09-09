actions
setProperty: propName to: value relationshipAt: relId 
	| resp |
	resp := self rawClient setProperty: propName to: value relationshipAt: relId.
	^ resp code ~= 404