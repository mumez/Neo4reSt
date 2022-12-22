accessing-stats
nodesCreated
	^self stats at: #nodes_created ifAbsent: [ 0 ]