actions-labels
addLabels: labels nodeAt: nodeId
	| jsonString urlString |
	urlString := self nodeUri // nodeId / 'labels'.
	jsonString := self portableUtil jsonStringFrom: labels.
	^ self portableUtil httpJsonPost: urlString content: jsonString 