actions
addKey: key value: value for: graphEntry
	^self restClient addRelationshipIndex: self name on: graphEntry uri key: key value: value