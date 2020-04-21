global operations
nodesLabeled: label havingAll: assocArray
	| predicates resp |
	predicates := self andPredicatesForNodeFrom: assocArray.
	resp := self queryByCypher: ('MATCH (n:{1}) where {2} RETURN id(n)' format: {label. predicates}).
	^self nodesFromCypherResponse: resp