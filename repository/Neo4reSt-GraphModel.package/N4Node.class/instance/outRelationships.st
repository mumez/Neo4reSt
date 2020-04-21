accessing-relationships
outRelationships
	| jsons |
	jsons := self restClient getOutRelationshipsAt: self id.
	^jsons collect: [:each | self db relationshipClass json: each for: self]