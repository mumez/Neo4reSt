converting
convertToNative: value using: settings
	value isString ifTrue: [^ self nativeStringFrom: value].
	^value