global operations
countNodesLabeled: label
	| resp |
	resp := self queryByCypher: (('MATCH (n:{1}) RETURN count(n)') format: {label}).
	^(resp result data first at: 'row') first