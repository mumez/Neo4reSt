deprecated-indexes
removeNodeIndexes: indexName on: nodeId
	^ self portableUtil httpJsonDelete: (self indexUri / 'node' // indexName // nodeId) 