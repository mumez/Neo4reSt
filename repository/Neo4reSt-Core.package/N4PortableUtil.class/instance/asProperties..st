converting
asProperties: someProps

	^someProps isArray ifTrue: [someProps] ifFalse: [Array with: someProps].