deprecated-labels
getNodeLabelsAt: nodeId 
	^ self portableUtil getJsonOrEmptyFrom: self nodeUri // nodeId asString / 'labels'