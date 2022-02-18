deprecated-rest
deleteRelationshipAt: relId 
	^ self portableUtil httpJsonDelete: self relationshipUri // relId