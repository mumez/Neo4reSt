accessing-relationships
inRelationshipsTyped: typeOrTypes having: key value: value
	^ self inRelationshipsTyped: typeOrTypes havingAll: {key->value} endNodeWithLabels: {} havingAll: {}