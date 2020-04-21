testing
testCopiedContatenate
	"self debug: #testCopiedContatenate"
	| baseUrl copiedUrl copiedUrl2 |
	baseUrl := N4Url baseUrlString: 'http://example.com'.
	copiedUrl := baseUrl , 'sub' // 'subsub'.
	self assert: (baseUrl asString = 'http://example.com/').
	self assert: (copiedUrl asString = 'http://example.com/sub/subsub').
	
	copiedUrl2 := baseUrl , 'sub2' / 2 / 'subsub'.
	self assert: (baseUrl asString = 'http://example.com/').
	self assert: (copiedUrl2 asString = 'http://example.com/sub2/2/subsub').
	
	