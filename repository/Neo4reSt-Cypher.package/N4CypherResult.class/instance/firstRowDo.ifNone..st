accessing
firstRowDo: aBlock ifNone: noneBlock
	^ self
		  firstDo: [ :dt | 
			  dt
				  at: #row
				  ifPresent: [ :row | 
				  aBlock value: row ] ]
		  ifNone: noneBlock