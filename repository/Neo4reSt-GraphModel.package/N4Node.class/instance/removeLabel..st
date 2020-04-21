actions-labels
removeLabel: label
	^self restClient deleteLabel: label nodeAt: self id