read/write
jsonStringFrom: valueOrAssocs 
	| rawJsonString param |
	((valueOrAssocs isArray or: [valueOrAssocs class = OrderedCollection])
		and: [valueOrAssocs notEmpty and: [valueOrAssocs first isKindOf: Association]])
		ifTrue: [param := self dictionaryFromAssociations: valueOrAssocs]
		ifFalse: [param := valueOrAssocs].
	rawJsonString := Json render: param.
	^ self utf8StringFrom: rawJsonString