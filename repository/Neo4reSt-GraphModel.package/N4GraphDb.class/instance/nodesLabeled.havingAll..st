actions-nodes
nodesLabeled: labelOrLabels havingAll: assocArray
	^self nodesLabeled: labelOrLabels where: [:node | node havingAll: assocArray]