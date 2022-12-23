accessing-stats
systemUpdates
	^self stats at: #system_updates ifAbsent: [ 0 ]