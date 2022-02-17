deprecated-indexes
removeNodeIndexes: indexName on: nodeId key: key value: value
	^ self portableUtil httpJsonDelete: (self indexUri / 'node' // indexName // key // value // nodeId) 