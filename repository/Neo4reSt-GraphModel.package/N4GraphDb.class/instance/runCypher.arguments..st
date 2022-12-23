actions-cypher
runCypher: cypherQueryOrString arguments: argsDict
	| queryString |
	queryString := cypherQueryOrString isString
		               ifTrue: [ cypherQueryOrString ]
		               ifFalse: [ cypherQueryOrString cypherString ].
	^ self queryByCypher: queryString arguments: argsDict 