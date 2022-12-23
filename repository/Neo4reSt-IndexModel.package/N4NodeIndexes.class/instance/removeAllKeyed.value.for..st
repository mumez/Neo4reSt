actions
removeAllKeyed: key value: value for: graphEntry
	^self httpClient removeNodeIndexes: self name from: graphEntry id key: key value: value