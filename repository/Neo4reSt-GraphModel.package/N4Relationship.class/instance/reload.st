loading
reload
	| newGraphObject |
	newGraphObject := self db relationshipAt: self id.
	self rawGraphObject: newGraphObject.