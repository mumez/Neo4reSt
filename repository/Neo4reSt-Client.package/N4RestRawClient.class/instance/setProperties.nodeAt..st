deprecated-rest
setProperties: properties nodeAt: nodeId
	| jsonString urlString |
	urlString := self nodeUri // nodeId / 'properties'.
	jsonString := self portableUtil jsonStringFrom: properties.
	^ self portableUtil httpJsonPut: urlString content: jsonString 