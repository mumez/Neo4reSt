deprecated-rest
deleteProperty: propName nodeAt: nodeId 
	^ self portableUtil httpJsonDelete: self nodeUri // nodeId / 'properties' // propName