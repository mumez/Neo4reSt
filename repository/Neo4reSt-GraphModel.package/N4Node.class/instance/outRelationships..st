accessing-relationships
outRelationships: type
	| jsons |
	jsons := self restClient getOutRelationshipsAt: self id type: type.
	^jsons collect: [:each | self db relationshipClass json: each for: self]