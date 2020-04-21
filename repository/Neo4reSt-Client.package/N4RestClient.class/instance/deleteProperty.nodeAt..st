actions
deleteProperty: propName nodeAt: nodeId 
	| response |
	response := self rawClient deleteProperty: propName nodeAt: nodeId.
	^ response code = 204