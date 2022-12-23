deprecated-rest
setProperties: properties relationshipAt: relId
	| jsonString urlString |
	urlString := self relationshipUri // relId / 'properties'.
	jsonString := self portableUtil jsonStringFrom: properties.
	^ self portableUtil httpJsonPut: urlString content: jsonString 