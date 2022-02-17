actions-deprecated
createNodeLabeled: label
	| node |
	node := self createNode.
	node addLabel: label.
	^node