relationships
relateToNewNode: typeName nodePropertues: nodePropertues relationshipProperties: relProperties
	| newNode |
	newNode := self db createNode: nodePropertues.
	self relateTo: newNode typed: {typeName} properties: relProperties.
	^newNode