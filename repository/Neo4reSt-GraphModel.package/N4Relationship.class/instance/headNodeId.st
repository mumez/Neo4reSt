accessing
headNodeId
	self direction == #in ifTrue: [ self startNodeId ].
	^ self endNodeId