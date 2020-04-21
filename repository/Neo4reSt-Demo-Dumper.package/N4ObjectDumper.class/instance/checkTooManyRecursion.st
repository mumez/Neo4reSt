private
checkTooManyRecursion
	self count: (self count + 1).
	self count >= 1000000 ifTrue: [self halt]