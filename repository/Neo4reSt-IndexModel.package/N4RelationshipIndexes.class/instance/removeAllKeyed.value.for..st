actions
removeAllKeyed: key value: value for: graphEntry
	^self httpClient removeRelationshipIndexes: self name from: graphEntry id key: key value: value