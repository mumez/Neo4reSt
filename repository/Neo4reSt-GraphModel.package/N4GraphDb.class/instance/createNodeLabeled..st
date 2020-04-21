actions
createNodeLabeled: label
	| node |
	node := self createNode.
	node addLabel: label.
	^node