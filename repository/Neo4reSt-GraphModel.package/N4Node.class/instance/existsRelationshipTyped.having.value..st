accessing-relationships-existence
existsRelationshipTyped: typeOrTypes having: key value: value
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #none
		from: self id
		whereIn: [:start :rel :end | (rel prop: key) = value]