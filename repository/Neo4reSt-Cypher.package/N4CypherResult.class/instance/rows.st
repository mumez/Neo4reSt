accessing-rows
rows
	| rows |
	rows := OrderedCollection new.
	self allRowsDo: [ :row | rows add: row ].
	^rows