cypher-convenience
outRelationshipsFromGraphResult: aCypherGraphResult
	^ aCypherGraphResult relationships collect:[ :rel | self relationshipClass on: rel beOut from: self]