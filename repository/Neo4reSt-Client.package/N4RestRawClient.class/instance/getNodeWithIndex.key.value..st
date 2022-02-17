deprecated-rest
getNodeWithIndex: indexName key: key value: value
	^ self portableUtil getJsonFrom: self indexUri / 'node' // indexName // key // value