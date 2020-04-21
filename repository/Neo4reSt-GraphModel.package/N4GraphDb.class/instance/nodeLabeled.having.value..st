global operations
nodeLabeled: label having: key value: value
	| valueParam resp |
	valueParam := self asValueParameter: value.
	resp := self queryByCypher: ('MATCH (n:{1}) where n.{2}={3} RETURN id(n) LIMIT 1' format: {label. key. valueParam}).
	^self nodeFromCypherResponse: resp