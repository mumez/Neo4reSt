accessing-relationships-old
allRelationships: type
	| jsons |
	jsons := self httpClient getAllRelationshipsAt: self id type: type.
	^jsons collect: [:each | self db relationshipClass json: each for: self]