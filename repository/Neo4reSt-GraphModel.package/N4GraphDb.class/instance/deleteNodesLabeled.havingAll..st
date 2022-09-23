actions-nodes
deleteNodesLabeled: labelOrLabels havingAll: assocArray
	^self deleteNodesLabeled: labelOrLabels where: [:node | node havingAll: assocArray]