global operations
removeAllRelationships
	| resp |
	resp := self queryByCypher: 'START n=node(*)
MATCH n-[r]-()
DELETE r'.
	^resp hasErrors not