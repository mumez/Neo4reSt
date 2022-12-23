accessing
allLabels
	| n node paramId query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n.
	paramId := 'id' asCypherParameter. 
	query := CyQuery match: node where: (n getId equals: paramId)
		return: (CyFuncInvocation labels: node).
	^ (self db queryByCypher: query cypherString arguments: { paramId -> self id })	
		resultDo: [ :result | result firstRowDo: [ :row | row first ] ]