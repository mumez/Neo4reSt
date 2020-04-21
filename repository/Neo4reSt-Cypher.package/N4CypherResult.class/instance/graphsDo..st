enumeration
graphsDo: eachGraphNodesAndRelationshipsBlock
	^ self
		dataDo: [ :eachData | 
			| graphData |
			graphData := eachData at: 'graph' ifAbsent: [].
			graphData
				ifNotNil: [ eachGraphNodesAndRelationshipsBlock value: (graphData at: 'nodes' ifAbsent: [ #() ]) value: (graphData at: 'relationships' ifAbsent: [ #() ]) ] ]