global operations
allRelationshipTypes
	| resp |
	resp := self queryByCypher: 'MATCH (n)-[r]-() RETURN distinct type(r)'.
	^self firstFieldValuesOf: resp