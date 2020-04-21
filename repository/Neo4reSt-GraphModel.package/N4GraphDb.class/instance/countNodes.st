global operations
countNodes
	| resp |
	resp := self queryByCypher: 'MATCH (n) RETURN count(n)'.
	^(resp result data first at: 'row') first