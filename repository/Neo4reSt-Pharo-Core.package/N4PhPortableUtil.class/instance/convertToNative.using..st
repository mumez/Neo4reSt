converting
convertToNative: value using: settingsDict
	"Zinc automatically decode value, so this is not needed anymore"
	"value isString ifTrue: [^ self nativeStringFrom: value]."
	^value
