global operations
removeAllNodes
	| resp |
	resp := self queryByCypher: 'MATCH (n) DELETE n'.
	^resp hasErrors not