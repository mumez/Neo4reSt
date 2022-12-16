actions-cypher
runCypher: cypherQuery params: params format: graphOrRow stats: aBoolean
	| resultDataContents resp |
	resultDataContents := nil.
	graphOrRow == #row ifTrue: [ resultDataContents := #(row) ].
	graphOrRow == #graph ifTrue: [ resultDataContents := #(graph) ].
	self logInfo: {cypherQuery. params. graphOrRow. aBoolean} tag: #runCypher:params:format:stats:.
	resp := self queryByCypher: cypherQuery cypherString params: params resultDataContents: resultDataContents includeStats: aBoolean.
	resp signalIfError.
	^resp