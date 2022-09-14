accessing
firstGraphDo: aBlock ifNone: noneBlock
	^ self
		  firstDo: [ :dt | 
			  dt
				  at: #graph
				  ifPresent: [ :p | 
				  aBlock value: (N4CypherGraphResult fromDictionary: p) ] ]
		  ifNone: noneBlock