properties
removePropertyAt: propName ifAbsent: aBlock
	^ self properties removeKey: propName ifAbsent: aBlock