deprecated-indexes
addNodeIndex: indexName on: nodeUri key: key value: value
	|json jsonString |
	json := self newNodeIndexJson: nodeUri key: key value: value.
	jsonString := self portableUtil jsonStringFrom: json.
	^ self portableUtil httpJsonPost: (self indexUri / 'node' // indexName) content: jsonString