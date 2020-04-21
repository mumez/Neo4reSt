enumeration
graphsNodesDo: eachGraphNodesBlock relationshipsDo: eachGraphRelsBlock
	^ self
		dataDo: [ :eachData | 
			| graphData |
			graphData := eachData at: 'graph' ifAbsent: [].
			graphData
				ifNotNil: [ 
					(graphData at: 'nodes' ifAbsent: [ #() ]) do: eachGraphNodesBlock.
					(graphData at: 'relationships' ifAbsent: [ #() ]) do: eachGraphRelsBlock ] ]