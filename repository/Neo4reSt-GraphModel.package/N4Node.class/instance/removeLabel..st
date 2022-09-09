actions-labels
removeLabel: label
	^self httpClient deleteLabel: label nodeAt: self id