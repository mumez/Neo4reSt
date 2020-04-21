private-dumping
dumpClassInfo: anObject to: aNode
	aNode at: '_className' put: anObject class name asString. 
	aNode at: '_superclassName' put: anObject class superclass name. 