global operations
removeRelationshipsOfType: type
	| resp |
	resp := self queryByCypher: ('MATCH ()-[r:{1}]-() DELETE r' format: {type}).
	^resp hasErrors not