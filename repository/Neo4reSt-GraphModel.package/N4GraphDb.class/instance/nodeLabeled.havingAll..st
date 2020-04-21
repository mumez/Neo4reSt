global operations
nodeLabeled: label havingAll: assocArray
	| predicates resp    |
	predicates := self andPredicatesForNodeFrom: assocArray.
	resp := self queryByCypher: ('MATCH (n:{1}) where {2} RETURN id(n) LIMIT 1' format: {label. predicates}).
	^self nodeFromCypherResponse: resp