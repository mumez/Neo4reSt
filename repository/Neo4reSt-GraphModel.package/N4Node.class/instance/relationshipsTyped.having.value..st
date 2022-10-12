accessing-relationships
relationshipsTyped: typeOrTypes having: key value: value
	^ self relationshipsTyped: typeOrTypes havingAll: {key->value} endNodeWithLabels: {} havingAll: {}