dumping
dump: startObject 
	| newNode |
	newNode := self db createNode.
	self labelStartNode: newNode.
	self dumpObject: startObject to: newNode
	
