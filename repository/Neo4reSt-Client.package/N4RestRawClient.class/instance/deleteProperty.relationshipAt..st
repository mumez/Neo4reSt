actions
deleteProperty: propName relationshipAt: relId 
	^ self portableUtil httpJsonDelete: self relationshipUri // relId / 'properties' // propName