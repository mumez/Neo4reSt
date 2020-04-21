global operations
ensureNodeLabeled: label having: key value: value
	| valueParam resp |
	valueParam := self asValueParameter: value.
	resp := self queryByCypher: ('MERGE (n:{1} \{{2}:{3}\}) RETURN id(n)' format: {label. key. valueParam}).
	^self nodeFromCypherResponse: resp