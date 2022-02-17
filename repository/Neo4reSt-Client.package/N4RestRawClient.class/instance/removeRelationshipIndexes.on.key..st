deprecated-indexes
removeRelationshipIndexes: indexName on: relId key: key
	^ self portableUtil httpJsonDelete: (self indexUri / 'relationship' // indexName // key // relId) 