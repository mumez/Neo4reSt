actions
deleteNodeAt: id 
	^ self portableUtil httpJsonDelete: self nodeUri // id