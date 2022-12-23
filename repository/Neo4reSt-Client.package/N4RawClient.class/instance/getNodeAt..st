deprecated-rest
getNodeAt: id 
	^ self portableUtil httpJsonGet: self nodeUri // id
		