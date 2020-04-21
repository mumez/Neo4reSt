global operations
countRelationships
	| resp |
	resp := self queryByCypher: 'MATCH ()-[r]-() RETURN count(distinct id(r))'.
	^(resp result data first at: 'row') first