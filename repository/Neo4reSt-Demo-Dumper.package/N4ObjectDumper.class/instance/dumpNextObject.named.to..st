private-dumping
dumpNextObject: nextObj named: eachName to: aNode 
	| newNode |
	newNode := self db createNode.
	aNode relateTo: newNode type: eachName.
	self dumpObject: nextObj to: newNode