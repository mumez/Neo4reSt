accessing-relationships
allRelationships
	| jsons |
	jsons := self httpClient getAllRelationshipsAt: self id.
	^jsons collect: [:each | self db relationshipClass json: each for: self]