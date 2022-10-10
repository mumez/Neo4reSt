accessing-relationships-old
existsRelationshipOfType: relType having: key value: value
	^(self relationshipsOfType: relType having: key value: value) notEmpty