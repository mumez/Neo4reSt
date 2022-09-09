actions-labels
deleteLabel: label nodeAt: nodeId
	| response |
	response := self rawClient deleteLabel: label nodeAt: nodeId.
	^ response code = 204