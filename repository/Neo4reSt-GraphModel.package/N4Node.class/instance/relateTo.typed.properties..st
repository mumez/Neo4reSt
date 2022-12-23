relationships
relateTo: otherNode typed: type properties: propertiesArray
	| newRelationship |
	newRelationship := self db createOutRelationshipTyped: type fromNodeId: self id toNodeId: otherNode id properties: propertiesArray.
	^ newRelationship