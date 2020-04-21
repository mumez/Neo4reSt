global operations
countRelationshipsLabeled: label
	| resp |
	resp := self queryByCypher: ('MATCH ()-[r:{1}]-() RETURN count(distinct id(r))' format: {label}).
	^(resp result data first at: 'row') first