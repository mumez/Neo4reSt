actions-cypher
runCypher: cypherQuery params: params format: graphOrRow stats: aBoolean
	| resultDataContents resp |
	resultDataContents := nil.
	graphOrRow == #row ifTrue: [ resultDataContents := #(row) ].
	graphOrRow == #graph ifTrue: [ resultDataContents := #(graph) ].
	
	resp := self queryByCypher: cypherQuery cypherString params: params resultDataContents: resultDataContents includeStats: aBoolean.
	resp signalIfError.
	^resp