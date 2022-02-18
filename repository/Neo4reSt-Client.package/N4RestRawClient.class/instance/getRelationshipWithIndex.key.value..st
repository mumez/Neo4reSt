deprecated-rest
getRelationshipWithIndex: indexName key: key value: value
	^ self portableUtil getJsonFrom: self indexUri / 'relationship' // indexName // key // value