accessing-relationships
allRelationships
	| jsons |
	jsons := self restClient getAllRelationshipsAt: self id.
	^jsons collect: [:each | self db relationshipClass json: each for: self]