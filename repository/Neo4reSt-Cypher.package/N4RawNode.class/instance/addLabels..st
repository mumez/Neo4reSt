accessing
addLabels: aCollection
	self labels: (self labels asSet addAll: aCollection; yourself) asArray.
	^ self labels