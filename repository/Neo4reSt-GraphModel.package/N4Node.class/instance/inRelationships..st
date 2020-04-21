accessing-relationships
inRelationships: type
	| jsons |
	jsons := self restClient getInRelationshipsAt: self id type: type.
	^jsons collect: [:each | self db relationshipClass json: each for: self]