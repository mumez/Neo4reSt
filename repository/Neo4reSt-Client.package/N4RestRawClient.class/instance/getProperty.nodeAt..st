actions
getProperty: propName nodeAt: nodeId
	^ self portableUtil getJsonFrom: self nodeUri // nodeId / 'properties' // propName