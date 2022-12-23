deprecated-indexes
removeRelationshipIndexes: indexName on: relId
	^ self portableUtil httpJsonDelete: (self indexUri / 'relationship' // indexName // relId) 