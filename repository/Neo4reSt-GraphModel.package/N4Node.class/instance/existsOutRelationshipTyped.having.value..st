accessing-relationships-existence
existsOutRelationshipTyped: typeOrTypes having: key value: value
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #out
		from: self id
		whereIn: [:start :rel :end | (rel prop: key) = value]