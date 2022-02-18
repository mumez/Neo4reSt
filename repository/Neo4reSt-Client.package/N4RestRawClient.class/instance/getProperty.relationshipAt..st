deprecated-rest
getProperty: propName relationshipAt: relId
	^ self portableUtil getJsonFrom: self relationshipUri // relId / 'properties' // propName