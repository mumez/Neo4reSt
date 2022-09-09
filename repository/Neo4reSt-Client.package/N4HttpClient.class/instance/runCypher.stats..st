private-cypher
runCypher: cypherQuery stats: aBoolean
	| resp |
	resp := self queryByCypher: cypherQuery cypherString params: nil resultDataContents: nil includeStats: aBoolean.
	resp hasErrors ifTrue: [ (N4CypherError response: resp) signal].
	resp inspect.
	^resp