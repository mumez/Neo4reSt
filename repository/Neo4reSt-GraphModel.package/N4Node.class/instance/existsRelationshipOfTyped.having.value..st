accessing-relationships-existence
existsRelationshipOfTyped: typeOrTypes having: key value: value
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #none
		from: self id
		whereIn: [:start :rel :end | (rel prop: key) = value]