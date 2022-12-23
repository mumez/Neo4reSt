accessing-rows
allValues
	| values |
	values := OrderedCollection new.
	self allRowsDo: [:row | values add: row ].
	^ values