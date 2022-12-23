properties
properties: props
	props ifNil: [ ^ properties := nil ].
	properties := props asDictionary