relationships
relateOneToNewNode: typeName 
	| newNode |
	newNode := self db createNode.
	self relateOneTo: newNode type: typeName.
	^newNode