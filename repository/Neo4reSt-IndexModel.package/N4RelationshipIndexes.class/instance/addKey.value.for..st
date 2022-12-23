actions
addKey: key value: value for: graphEntry
	^self httpClient addRelationshipIndex: self name on: graphEntry uri key: key value: value