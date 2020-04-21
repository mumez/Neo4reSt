actions
getPropertiesRelationshipAt: relId 
	^ self portableUtil getJsonOrEmptyFrom: self relationshipUri // relId / 'properties'