actions-cypher
runCyphers: cypherQueryOrStrings
	| queryStrings |
	queryStrings := cypherQueryOrStrings collect: [:each | each isString
		               ifTrue: [ each ]
		               ifFalse: [ each cypherString ]].
	^ self queryByCyphers: queryStrings