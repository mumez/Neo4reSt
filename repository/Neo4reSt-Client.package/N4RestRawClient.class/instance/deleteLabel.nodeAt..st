deprecated-labels
deleteLabel: label nodeAt: nodeId
	|  urlString |
	urlString := self nodeUri // nodeId / 'labels' / label.
	^ self portableUtil httpJsonDelete: urlString