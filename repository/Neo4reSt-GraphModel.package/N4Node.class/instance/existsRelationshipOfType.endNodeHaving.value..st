accessing-relationships
existsRelationshipOfType: relType endNodeHaving: key value: value
	^(self relationshipsOfType: relType endNodeHaving: key value: value) notEmpty