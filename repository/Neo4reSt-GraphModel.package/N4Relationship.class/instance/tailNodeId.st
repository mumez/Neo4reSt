accessing
tailNodeId
	self direction == #in ifTrue: [ self endNodeId ].
	^ self startNodeId