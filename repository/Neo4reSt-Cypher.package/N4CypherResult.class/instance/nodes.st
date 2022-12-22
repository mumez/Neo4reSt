accessing-graph
nodes
	| nodes |
	nodes := OrderedCollection new.
	self allGraphsDo: [ :graphResult |
		nodes addAll: graphResult nodes
	].
	^ nodes