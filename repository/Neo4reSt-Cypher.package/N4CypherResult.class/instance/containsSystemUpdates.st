accessing-stats
containsSystemUpdates
	^self stats at: #contains_system_updates ifAbsent: [ false ]