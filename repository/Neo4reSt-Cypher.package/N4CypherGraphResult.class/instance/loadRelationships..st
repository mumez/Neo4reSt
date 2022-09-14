loading
loadRelationships: relationshipDicts
	relationships := relationshipDicts collect: [ :each | self loadRelationshipFrom: each ]