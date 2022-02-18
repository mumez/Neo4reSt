deprecated-rest
deleteNodeAt: id 
	^ self portableUtil httpJsonDelete: self nodeUri // id