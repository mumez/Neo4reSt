actions-indexes
deleteRelationshipIndexes: indexName
	^ self portableUtil httpJsonDelete: self indexUri / 'relationship' // indexName