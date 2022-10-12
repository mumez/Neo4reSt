accessing-relationships
relationshipsTyped: typeOrTypes endNodeHaving: key value: value
	^ self relationshipsTyped: typeOrTypes havingAll: {} endNodeWithLabels: {} havingAll: {key->value}