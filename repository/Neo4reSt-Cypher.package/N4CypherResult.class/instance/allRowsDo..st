accessing
allRowsDo: aBlock
	^ self
		  allDataDo: [ :dt | 
			  dt
				  at: #row
				  ifPresent: [ :row | 
				  aBlock value: row ] ]