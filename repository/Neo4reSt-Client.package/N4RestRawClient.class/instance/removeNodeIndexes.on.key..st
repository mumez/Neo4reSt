actions-indexes
removeNodeIndexes: indexName on: nodeId key: key
	^ self portableUtil httpJsonDelete: (self indexUri / 'node' // indexName // key // nodeId) 