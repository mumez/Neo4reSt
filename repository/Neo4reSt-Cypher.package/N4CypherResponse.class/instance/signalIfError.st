actions
signalIfError
	self hasErrors ifTrue: [ (N4CypherError response: self) signal].