deprecated-rest
getRelationshipAt: id 
	^ self portableUtil getJsonFrom: self relationshipUri // id
		