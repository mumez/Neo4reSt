global operations
removeAllNodes
	| resp |
	resp := self queryByCypher: 'START n=node(*)
MATCH n
DELETE n'.
	^resp hasErrors not