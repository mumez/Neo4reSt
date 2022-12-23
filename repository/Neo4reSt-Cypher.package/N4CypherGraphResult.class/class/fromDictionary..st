instance creation
fromDictionary: aDictionary
	| inst |
	inst := self new.
	aDictionary at: #nodes ifPresent: [ :nodes | inst loadNodes: nodes ].
	aDictionary at: #relationships ifPresent: [ :relationships | inst loadRelationships: relationships ].
	^ inst