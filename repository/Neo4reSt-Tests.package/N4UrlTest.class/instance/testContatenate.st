testing
testContatenate
	"self debug: #testContatenate"
	| baseUrl baseUrl2 baseUrl3 baseUrl4 |
	baseUrl := N4Url baseUrlString: 'http://example.com'.
	baseUrl / 'sub' // 'subsub'.
	self assert: (baseUrl asString = 'http://example.com/sub/subsub').
	
	baseUrl2 := N4Url baseUrlString: 'http://example.com/'.
	baseUrl2 / 'sub' / 1 / 'subsub'.
	self assert: (baseUrl2 asString = 'http://example.com/sub/1/subsub').
	
	baseUrl3 := N4Url baseUrlString: 'http://example.com/'.
	baseUrl3 / 'sub' / '1/2' / 'subsub'.
	self assert: (baseUrl3 asString = 'http://example.com/sub/1/2/subsub').
	
	baseUrl4 := N4Url baseUrlString: 'http://example.com/'.
	baseUrl4 / 'sub' // '1/2' / 'subsub'.
	self assert: (baseUrl4 asString = 'http://example.com/sub/1%2F2/subsub').