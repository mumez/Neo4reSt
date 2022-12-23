cypher-convenience
inRelationshipsFromGraphResult: aCypherGraphResult
	^ aCypherGraphResult relationships collect:[ :rel | self relationshipClass on: rel beIn from: self db]