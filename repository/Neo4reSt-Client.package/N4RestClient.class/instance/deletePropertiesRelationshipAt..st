actions
deletePropertiesRelationshipAt: relId 
	| response |
	response := self rawClient deletePropertiesRelationshipAt: relId.
	^ response code = 204