stream-like
next
	| parsed |
	parsed := self parse: (self json at: self index).
	self index: self index + 1.
	^parsed