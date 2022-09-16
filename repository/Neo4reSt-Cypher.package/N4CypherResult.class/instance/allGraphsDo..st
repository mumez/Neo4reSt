accessing
allGraphsDo: aBlock
	^ self
		  allDataDo: [ :dt | 
			  dt
				  at: #graph
				  ifPresent: [ :p | 
				  aBlock value: (N4CypherGraphResult fromDictionary: p) ] ]