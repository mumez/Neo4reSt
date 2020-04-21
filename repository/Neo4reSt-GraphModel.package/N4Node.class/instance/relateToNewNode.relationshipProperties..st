relationships
relateToNewNode: typeName relationshipProperties: relProperties
	| newNode |
	newNode := self db createNode.
	self relateTo: newNode type: typeName properties: relProperties.
	^newNode