relationships
relateTo: otherNode typed: types properties: propertiesArray
	| newRelationship |
	newRelationship := self db createOutRelationshipTyped: types fromNodeId: self id toNodeId: otherNode id properties: propertiesArray.
	^ newRelationship