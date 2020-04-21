actions-labels
setLabels: labels nodeAt: nodeId
	| jsonString urlString |
	urlString := self nodeUri // nodeId / 'labels'.
	jsonString := self portableUtil jsonStringFrom: labels.
	^ self portableUtil httpJsonPut: urlString content: jsonString 