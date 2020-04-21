actions
deletePropertiesNodeAt: nodeId 
	| response |
	response := self rawClient deletePropertiesNodeAt: nodeId.
	^ response code = 204