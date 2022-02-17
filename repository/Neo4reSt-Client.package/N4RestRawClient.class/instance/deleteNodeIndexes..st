deprecated-indexes
deleteNodeIndexes: indexName
	^ self portableUtil httpJsonDelete: self indexUri / 'node' // indexName 