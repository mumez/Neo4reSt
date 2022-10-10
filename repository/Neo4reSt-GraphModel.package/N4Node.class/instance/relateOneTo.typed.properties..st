relationships
relateOneTo: otherNode typed: types properties: propertiesArray
	| newRelationship |
	newRelationship := self db mergeOutRelationshipTyped: types fromNodeId: self id toNodeId: otherNode id properties: propertiesArray.
	^ newRelationship