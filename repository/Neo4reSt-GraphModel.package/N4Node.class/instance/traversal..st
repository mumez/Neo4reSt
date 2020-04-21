traversal
traversal: settingBlock
	| trav |
	trav := N4Traversal from: self.
	settingBlock value: trav.
	^trav