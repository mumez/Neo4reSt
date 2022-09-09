actions-multiple-query
queryByCyphersUsing: queryBuildingBlock
	| resp |
	resp := self rawClient queryByCyphersUsing: queryBuildingBlock.
	^N4CypherResponse json: (self portableUtil readJsonFromResponse: resp)