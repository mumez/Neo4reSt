relationships
relateOneTo: otherNode type: typeName
	| resp |
	resp := self db queryByCypher: ('MATCH (m),(s) WHERE id(m)={1} AND id(s)={2} MERGE m-[r:{3}]->s RETURN distinct id(r), type(r), id(startNode(r)), id(endNode(r))'
		format: {self id. otherNode id. typeName asString}).
	^(self db relationshipsFromCypherResponse: resp) first