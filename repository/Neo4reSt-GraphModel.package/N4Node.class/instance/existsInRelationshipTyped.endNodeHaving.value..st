accessing-relationships-existence
existsInRelationshipTyped: typeOrTypes endNodeHaving: key value: value
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #in
		from: self id
		whereIn: [:start :rel :end | (end prop: key) = value]