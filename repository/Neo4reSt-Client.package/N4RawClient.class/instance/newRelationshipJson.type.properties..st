deprecated-builder
newRelationshipJson: uriOrNodeId type: type properties: assocs
	| uri jsonAssocs |
	jsonAssocs := OrderedCollection new: 3.
	uri := uriOrNodeId asString.
	(self portableUtil string: uri beginsWith: 'http:') ifFalse: [uri := (self rootUri, 'node/', uri)].
	jsonAssocs add: ('to' -> uri).
	jsonAssocs add: ('type' -> type).
	(assocs isNil or: [assocs isEmpty]) ifFalse: [
		jsonAssocs add: ('data' -> (self portableUtil dictionaryFromAssociations: assocs))
	].
	^jsonAssocs