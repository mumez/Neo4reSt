deprecated-indexes
removeRelationshipIndexes: indexName on: relId key: key value: value
	^ self portableUtil httpJsonDelete: (self indexUri / 'node' // indexName // key // value // relId) 