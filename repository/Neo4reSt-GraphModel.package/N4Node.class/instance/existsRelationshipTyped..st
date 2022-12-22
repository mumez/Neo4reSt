accessing-relationships-existence
existsRelationshipTyped: typeOrTypes
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #none
		from: self id
		whereIn: [:start :rel :end |]