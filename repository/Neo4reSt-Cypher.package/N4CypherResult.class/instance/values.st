accessing-rows
values
	| values |
	values := OrderedCollection new.
	self allRowsDo: [:row | values add: (self firstOrAllOf: row)].
	^ self firstOrAllOf: values