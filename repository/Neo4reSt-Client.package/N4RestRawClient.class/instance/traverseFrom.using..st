deprecated-rest
traverseFrom: nodeId using: traversalDescription
	| jsonString urlString |
	urlString := self nodeUri // nodeId / 'traverse' // traversalDescription returnType.
	jsonString := self portableUtil jsonStringFrom: traversalDescription asDictionary.
	^ self portableUtil httpJsonPost: urlString content: jsonString 