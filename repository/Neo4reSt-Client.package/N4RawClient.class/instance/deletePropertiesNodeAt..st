deprecated-rest
deletePropertiesNodeAt: nodeId 
	^ self portableUtil httpJsonDelete: self nodeUri // nodeId / 'properties'