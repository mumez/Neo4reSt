actions
createNode: properties
	^ (self nodeClass from: (self restClient createNode: properties)) db: self