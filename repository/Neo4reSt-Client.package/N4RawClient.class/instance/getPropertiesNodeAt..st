deprecated-rest
getPropertiesNodeAt: nodeId 
	^ self portableUtil getJsonOrEmptyFrom: self nodeUri // nodeId asString / 'properties'