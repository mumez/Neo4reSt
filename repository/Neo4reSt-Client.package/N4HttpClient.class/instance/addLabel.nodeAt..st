actions-labels
addLabel: label nodeAt: nodeId
	|  resp |
	resp := self rawClient addLabel: label nodeAt: nodeId.
	^ resp code ~= 404