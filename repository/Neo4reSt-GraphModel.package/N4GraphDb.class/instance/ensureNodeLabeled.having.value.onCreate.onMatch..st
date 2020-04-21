global operations
ensureNodeLabeled: label having: key value: value onCreate: createProperties onMatch: properties
	| valueParam createPropSetPhrase propSetPhrase resp |
	valueParam := self asValueParameter: value.
	createPropSetPhrase := self propertySetParametersFrom: createProperties targetNamed: 'n'.
	propSetPhrase := self propertySetParametersFrom: properties targetNamed: 'n'.
	resp := self queryByCypher: ('MERGE (n:{1} \{{2}:{3}\}) ON CREATE {4} ON MATCH {5} RETURN id(n)' format: {label. key. valueParam. createPropSetPhrase. propSetPhrase}).
	^self nodeFromCypherResponse: resp