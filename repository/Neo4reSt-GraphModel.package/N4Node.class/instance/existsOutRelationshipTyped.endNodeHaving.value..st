accessing-relationships-existence
existsOutRelationshipTyped: typeOrTypes endNodeHaving: key value: value
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #out
		from: self id
		whereIn: [:start :rel :end | (end prop: key) = value]