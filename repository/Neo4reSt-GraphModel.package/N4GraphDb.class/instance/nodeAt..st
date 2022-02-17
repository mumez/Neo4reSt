actions-deprecated
nodeAt: nodeId 
	| resp |
	resp := self restClient getNodeAt: nodeId.
	resp code = 200
		ifTrue: [^ (self nodeClass id: nodeId) db: self]