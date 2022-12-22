accessing-relationships-existence
existsOutRelationshipTyped: typeOrTypes
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #out
		from: self id
		whereIn: [:start :rel :end |]