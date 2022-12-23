accessing-relationships
inRelationshipsTyped: typeOrTypes endNodeHaving: key value: value
	^ self inRelationshipsTyped: typeOrTypes havingAll: {} endNodeWithLabels: {} havingAll: {key->value}