relationships
relateTo: otherNode type: typeName
	| resp relationship |
	resp :=  self httpClient createRelationshipAt: self id to: otherNode uri type: typeName.
	relationship :=(self db relationshipClass from: resp) db: self db.
	relationship type: typeName.	
	relationship startNodeId: self id.
	relationship endNodeId: otherNode id.
	relationship direction: #out.
	^relationship