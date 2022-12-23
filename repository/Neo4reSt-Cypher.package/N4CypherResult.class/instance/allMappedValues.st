accessing-rows
allMappedValues
	| mappedValues |
	mappedValues := OrderedCollection new.
	self allRowsDo: [ :row | | dict |
		dict := Dictionary new.
		self columns withIndexDo: [ :column :idx |
			dict at: column put: (row at: idx)
		].
		mappedValues add: dict.
	].
	^ mappedValues