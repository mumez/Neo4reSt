accessing-stats
nodesDeleted
	^self stats at: #nodes_deleted ifAbsent: [ 0 ]