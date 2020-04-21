converting
asString
	| stream |
	self components isEmpty ifTrue: [^self baseUrlString].
	stream := WriteStream with: self baseUrlString.
	self components do: [:each | stream nextPutAll: each] separatedBy: [stream nextPut: $/].
	^stream contents