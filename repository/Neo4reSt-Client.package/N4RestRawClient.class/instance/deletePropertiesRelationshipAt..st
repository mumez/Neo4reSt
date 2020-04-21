actions
deletePropertiesRelationshipAt: relId 
	^ self portableUtil httpJsonDelete: self relationshipUri // relId asString / 'properties'