accessing
firstGraphDo: aBlock
	^ self firstDo: [ :dt | 
		  dt at: #graph ifPresent: [ :p | aBlock value: (N4CypherGraphResult fromDictionary: p) ] ]