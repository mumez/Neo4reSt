relationships
relateTo: otherNode type: typeName properties: assocs
	| resp relationship |
	resp :=  self httpClient createRelationshipAt: self id to: otherNode uri type: typeName properties: assocs.
	relationship :=(self db relationshipClass from: resp) db: self db.
	relationship type: typeName.	
	relationship properties: assocs.	
	relationship startNodeId: self id.
	relationship endNodeId: otherNode id.
	relationship direction: #out.
	^relationship