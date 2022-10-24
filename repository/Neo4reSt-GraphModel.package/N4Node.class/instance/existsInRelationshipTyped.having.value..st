accessing-relationships-existence
existsInRelationshipTyped: typeOrTypes having: key value: value
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #in
		from: self id
		whereIn: [:start :rel :end | (rel prop: key) = value]