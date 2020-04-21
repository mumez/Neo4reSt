relationships
relateToNewNode: typeName 
	| newNode |
	newNode := self db createNode.
	self relateTo: newNode type: typeName.
	^newNode