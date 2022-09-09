actions
deleteProperty: propName relationshipAt: relId 
	| response |
	response := self rawClient deleteProperty: propName relationshipAt: relId.
	^ response code = 204