actions-labels
setLabels: labels nodeAt: nodeId
	|  resp |
	resp := self rawClient setLabels: labels nodeAt: nodeId.
	^ resp code ~= 404