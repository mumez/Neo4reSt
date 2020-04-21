actions
deletePropertiesNodeAt: nodeId 
	^ self portableUtil httpJsonDelete: self nodeUri // nodeId / 'properties'