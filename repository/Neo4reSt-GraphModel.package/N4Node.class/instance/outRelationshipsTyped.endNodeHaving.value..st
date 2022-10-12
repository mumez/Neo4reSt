accessing-relationships
outRelationshipsTyped: typeOrTypes endNodeHaving: key value: value
	^ self outRelationshipsTyped: typeOrTypes havingAll: {} endNodeWithLabels: {} havingAll: {key->value}