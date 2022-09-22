actions-multiple-cypher
queryByCyphersUsing: queryBuildingBlock
	| resp |
	resp := self rawClient queryByCyphersUsing: queryBuildingBlock.
	^N4CypherResponse json: (self portableUtil readJsonFromResponse: resp)