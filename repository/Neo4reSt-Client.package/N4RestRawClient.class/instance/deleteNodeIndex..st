actions
deleteNodeIndex: indexName
	^ self portableUtil httpJsonDelete: self indexUri / 'node' // indexName