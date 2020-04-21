converting
urlEncodedStringFrom: anObject
	"By default - just escape slash - mostly we can leave full url encoding to the underlying http client"
	| str |
	str := self stringFrom: anObject.
	^str copyReplaceAll: '/' with: '%2F'