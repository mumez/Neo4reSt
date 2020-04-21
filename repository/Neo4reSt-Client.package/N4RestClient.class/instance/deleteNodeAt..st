actions
deleteNodeAt: id 
	| response |
	response := self rawClient deleteNodeAt: id.
	^ response code = 204