converting
asDictionary
	"order relationships uniqueness pruneEvaluator returnFilter maxDepth"
	| dict |
	dict := Dictionary new.
	self order ifNotNil: [dict at: 'order' put: self order].
	self relationships ifNotNil: [dict at: 'relationships' put: self relationships].
	self uniqueness ifNotNil: [dict at: 'uniqueness' put: self uniqueness].
	self pruneEvaluator ifNotNil: [dict at: 'pruneEvaluator' put: self pruneEvaluator].
	self returnFilter ifNotNil: [dict at: 'returnFilter' put: self returnFilter].
	self maxDepth ifNotNil: [dict at: 'maxDepth' put: self maxDepth].
	^dict