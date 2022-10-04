loading
reload
	| newGraphObject |
	newGraphObject := self db nodeAt: self id.
	self rawGraphObject: newGraphObject.