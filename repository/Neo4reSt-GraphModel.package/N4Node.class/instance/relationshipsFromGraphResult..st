cypher-convenience
relationshipsFromGraphResult: aCypherGraphResult
	^ aCypherGraphResult relationships collect:[ :rel | self relationshipClass on: rel from: self db]