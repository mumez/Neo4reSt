testing
testBasicContatenate
	"self debug: #testBasicContatenate"
	| baseUrl baseUrl2 |
	baseUrl := N4Url baseUrlString: 'http://example.com'.
	baseUrl / 'sub' / 'subsub'.
	self assert: (baseUrl asString = 'http://example.com/sub/subsub').
	
	baseUrl2 := N4Url baseUrlString: 'http://example2.com/'.
	baseUrl2 / 'sub' / 'subsub'.
	self assert: (baseUrl2 asString = 'http://example2.com/sub/subsub').