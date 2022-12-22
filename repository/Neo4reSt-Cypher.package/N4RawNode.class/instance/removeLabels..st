accessing
removeLabels: aCollection
	| removed |
	removed := self labels asOrderedCollection removeAllSuchThat: [:each | aCollection includes: each].
	self labels: removed asArray.
	^ self labels 