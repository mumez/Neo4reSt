accessing-stats
containsUpdates
	^self stats at: #contains_updates ifAbsent: [ false ]