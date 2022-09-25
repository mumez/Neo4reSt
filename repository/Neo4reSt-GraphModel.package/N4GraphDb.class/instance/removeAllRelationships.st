global operations
removeAllRelationships
	| resp |
	resp := self queryByCypher: 'MATCH ()-[r]-() DELETE r'.
	^resp hasErrors not