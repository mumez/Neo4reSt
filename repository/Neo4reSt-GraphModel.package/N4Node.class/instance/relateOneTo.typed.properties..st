relationships
relateOneTo: otherNode typed: type properties: propertiesArray
	| newRelationship |
	newRelationship := self db mergeOutRelationshipTyped: type fromNodeId: self id toNodeId: otherNode id properties: propertiesArray.
	^ newRelationship