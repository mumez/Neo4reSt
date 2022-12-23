accessing-graph
relationships
	| relationships |
	relationships := OrderedCollection new.
	self allGraphsDo: [ :graphResult |
		relationships addAll: graphResult relationships
	].
	^ relationships