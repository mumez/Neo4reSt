accessing
firstDo: aBlock ifNone: noneBlock
	^ (self firstOrNilOf: self data)
		  ifNil: noneBlock
		  ifNotNil: [ :val | aBlock value: val ]