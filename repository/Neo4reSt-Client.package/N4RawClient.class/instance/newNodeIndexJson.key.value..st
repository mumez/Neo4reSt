deprecated-builder
newNodeIndexJson: uriOrNodeId key: key value: value
	| uri jsonAssocs |
	jsonAssocs := OrderedCollection new: 3.
	uri := uriOrNodeId asString.
	(self portableUtil string: uri beginsWith: 'http:') ifFalse: [uri := (self rootUri, 'node/', uri)].
	jsonAssocs add: ('uri' -> uri).
	jsonAssocs add: ('key' -> key).
	jsonAssocs add: ('value' -> value).
	^jsonAssocs