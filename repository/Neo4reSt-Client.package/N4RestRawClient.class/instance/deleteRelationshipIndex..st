actions
deleteRelationshipIndex: indexName
	^ self portableUtil httpJsonDelete: self indexUri / 'relationship' // indexName