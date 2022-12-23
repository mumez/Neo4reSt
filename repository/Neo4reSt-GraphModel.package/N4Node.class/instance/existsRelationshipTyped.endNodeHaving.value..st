accessing-relationships-existence
existsRelationshipTyped: typeOrTypes endNodeHaving: key value: value
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #none
		from: self id
		whereIn: [:start :rel :end | (end prop: key) = value]