accessing
label
	| labels |
	labels := self labels.
	labels isEmpty ifTrue: [ ^nil ].
	^labels at: 1