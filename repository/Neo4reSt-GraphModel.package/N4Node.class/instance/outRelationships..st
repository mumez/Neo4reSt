accessing-relationships-old
outRelationships: type
	| jsons |
	jsons := self httpClient getOutRelationshipsAt: self id type: type.
	^jsons collect: [:each | self db relationshipClass json: each for: self]