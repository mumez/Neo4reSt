accessing-relationships
allRelationships: type
	| jsons |
	jsons := self restClient getAllRelationshipsAt: self id type: type.
	^jsons collect: [:each | self db relationshipClass json: each for: self]