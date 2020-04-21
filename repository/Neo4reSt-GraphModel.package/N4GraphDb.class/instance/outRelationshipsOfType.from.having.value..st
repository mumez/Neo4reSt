global operations
outRelationshipsOfType: relType from: startNode having: key value: value 
	| valueParam resp rels |
	valueParam := self asValueParameter: value.
	resp := self queryByCypher: ('MATCH (start)-[r:{1}]->(end) WHERE id(start)={2} AND r.{3}={4} RETURN distinct id(r), type(r), id(startNode(r)), id(endNode(r))' format: {relType. startNode id. key. valueParam}).
	rels := self relationshipsFromCypherResponse: resp.
	^rels