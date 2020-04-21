private-dumping
dumpObject: anObject to: aNode 
	self checkTooManyRecursion.
	self dumpClassInfo: anObject to: aNode.
	anObject class allInstVarNames
		do: [:eachName | 
			| childObj |
			childObj := anObject instVarNamed: eachName.
			(self shouldDumpAsProperty: childObj)
				ifTrue: [self dumpProperty: childObj named: eachName to: aNode]
				ifFalse: [self dumpNextObject: childObj named: eachName to: aNode]].
	anObject class isVariable
		ifTrue: [anObject
				keysAndValuesDo: [:key :value | 
					self dumpNextObject: value named: key to: aNode]]