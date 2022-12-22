instance creation
loadFromDictionary: aDictionary
	| inst |
	inst := self new.
	inst loadFromDictionary: aDictionary.
	^inst