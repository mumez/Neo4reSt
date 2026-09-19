Class {
	#name : 'N4UrlTest',
	#superclass : 'TestCase',
	#category : 'Neo4reSt-Tests',
	#package : 'Neo4reSt-Tests'
}

{ #category : 'testing' }
N4UrlTest >> testBasicContatenate [
	"self debug: #testBasicContatenate"
	| baseUrl baseUrl2 |
	baseUrl := N4Url baseUrlString: 'http://example.com'.
	baseUrl / 'sub' / 'subsub'.
	self assert: (baseUrl asString = 'http://example.com/sub/subsub').
	
	baseUrl2 := N4Url baseUrlString: 'http://example2.com/'.
	baseUrl2 / 'sub' / 'subsub'.
	self assert: (baseUrl2 asString = 'http://example2.com/sub/subsub').
]

{ #category : 'testing' }
N4UrlTest >> testContatenate [
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
]

{ #category : 'testing' }
N4UrlTest >> testCopiedContatenate [
	"self debug: #testCopiedContatenate"
	| baseUrl copiedUrl copiedUrl2 |
	baseUrl := N4Url baseUrlString: 'http://example.com'.
	copiedUrl := baseUrl , 'sub' // 'subsub'.
	self assert: (baseUrl asString = 'http://example.com/').
	self assert: (copiedUrl asString = 'http://example.com/sub/subsub').
	
	copiedUrl2 := baseUrl , 'sub2' / 2 / 'subsub'.
	self assert: (baseUrl asString = 'http://example.com/').
	self assert: (copiedUrl2 asString = 'http://example.com/sub2/2/subsub').
	
	
]
