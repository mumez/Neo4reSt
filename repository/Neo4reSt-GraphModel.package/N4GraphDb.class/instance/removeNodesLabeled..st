global operations
removeNodesLabeled: label
	| resp |
	resp := self queryByCypher: ('MATCH (n:{1}) DELETE n' format: {label}).
	^resp hasErrors not