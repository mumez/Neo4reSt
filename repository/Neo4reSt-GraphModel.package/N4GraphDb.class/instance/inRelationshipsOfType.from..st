global operations
inRelationshipsOfType: relType from: startNode
	| resp rels |
	resp := self queryByCypher: ('MATCH (start)<-[r:{1}]-(end) WHERE id(start)={2} RETURN distinct id(r), type(r), id(startNode(r)), id(endNode(r))' format: {relType. startNode id}).
	rels := self relationshipsFromCypherResponse: resp.
	^rels
	