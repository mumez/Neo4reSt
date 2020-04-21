private
asValueParameter: value
	^value isString ifTrue: [ '"',value,'"' ] ifFalse: [ value ].