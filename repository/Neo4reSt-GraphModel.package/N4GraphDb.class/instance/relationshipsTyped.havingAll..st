actions-relationships
relationshipsTyped: typeOrTyped havingAll: assocArray
	^self relationshipsTyped: typeOrTyped where: [:relationship | relationship havingAll: assocArray]