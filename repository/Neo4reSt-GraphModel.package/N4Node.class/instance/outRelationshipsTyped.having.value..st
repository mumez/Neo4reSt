accessing-relationships
outRelationshipsTyped: typeOrTypes having: key value: value
	^ self outRelationshipsTyped: typeOrTypes havingAll: {key->value} endNodeWithLabels: {} havingAll: {}