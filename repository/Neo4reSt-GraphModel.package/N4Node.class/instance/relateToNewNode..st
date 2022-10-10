relationships
relateToNewNode: typeName 
	| newNode |
	newNode := self db createNode.
	self relateTo: newNode typed: { typeName }. 
	^newNode