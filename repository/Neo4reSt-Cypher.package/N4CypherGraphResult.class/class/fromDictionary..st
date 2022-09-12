instance creation
fromDictionary: aDictionary
	| inst |
	inst := self new.
	aDictionary at: #nodes ifPresent: [ :nodes | inst nodes: nodes ].
	aDictionary at: #relationships ifPresent: [ :relationships | inst relationships: relationships ].
	^ inst