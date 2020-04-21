actions
createNode: properties labeled: label
	| node |
	node := self createNode: properties.
	node addLabel: label.
	^node