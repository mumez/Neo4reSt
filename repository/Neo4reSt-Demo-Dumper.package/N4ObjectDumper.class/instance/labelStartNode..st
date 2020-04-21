private
labelStartNode: startNode
	| timestampKey |
	timestampKey := DateAndTime now printString.
	db initialNode relateTo: startNode type: timestampKey