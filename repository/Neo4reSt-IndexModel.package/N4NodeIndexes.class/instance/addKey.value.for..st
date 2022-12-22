actions
addKey: key value: value for: graphEntry
	^self httpClient addNodeIndex: self name on: graphEntry uri key: key value: value