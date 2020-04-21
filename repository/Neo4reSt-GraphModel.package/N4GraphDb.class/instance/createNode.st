actions
createNode
	^ (self nodeClass from: self restClient createNode) db: self