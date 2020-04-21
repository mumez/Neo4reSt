actions
setProperty: propName to: value nodeAt: nodeId 
	| jsonString urlString |
	urlString := self nodeUri // nodeId / 'properties' // propName.
	jsonString := self portableUtil jsonStringFrom: value.
	^ self portableUtil httpJsonPut: urlString content: jsonString 