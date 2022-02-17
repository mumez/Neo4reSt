actions-deprecated
createNode: properties labeled: label
	| node |
	node := self createNode: properties.
	node addLabel: label.
	^node