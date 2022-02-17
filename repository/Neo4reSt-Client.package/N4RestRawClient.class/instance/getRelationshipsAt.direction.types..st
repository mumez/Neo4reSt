deprecated-rest
getRelationshipsAt: nodeId direction: direction types: typeCollection
	| uriStream |
	uriStream := WriteStream with: (self nodeUri // nodeId) asString.
	uriStream nextPutAll: '/relationships/' ; nextPutAll: (self portableUtil stringFrom: direction).
	(typeCollection isNil or: [typeCollection isEmpty]) ifFalse: [uriStream nextPut: $/.
		typeCollection do: [:each | uriStream nextPutAll: (self portableUtil urlEncodedStringFrom: each)] separatedBy: [uriStream nextPut: $&]
	].

	^ self portableUtil getJsonFrom: uriStream contents