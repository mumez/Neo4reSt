loading
loadRelationships: relationshipDicts
	relationships := relationshipDicts collect: [ :each | self loadNodeFrom: each ]