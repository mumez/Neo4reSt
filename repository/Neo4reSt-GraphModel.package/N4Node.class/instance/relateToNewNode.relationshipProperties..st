relationships
relateToNewNode: typeName relationshipProperties: relProperties
	| newNode |
	newNode := self db createNode.
	self relateTo: newNode typed: {typeName} properties: relProperties.
	^newNode