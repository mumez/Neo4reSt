deprecated-rest
setProperty: propName to: value relationshipAt: relId 
	| jsonString urlString |
	urlString := self relationshipUri // relId / 'properties' // propName.
	jsonString := self portableUtil jsonStringFrom: value.
	^ self portableUtil httpJsonPut: urlString content: jsonString 