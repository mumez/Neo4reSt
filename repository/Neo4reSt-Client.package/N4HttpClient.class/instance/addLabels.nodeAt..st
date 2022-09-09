actions-labels
addLabels: labels nodeAt: nodeId
	|  resp |
	resp := self rawClient addLabels: labels nodeAt: nodeId.
	^ resp code ~= 404