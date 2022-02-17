testing
testGet
	| resp urlString |
	urlString := 'http://localhost:7474/'.
	resp := N4PortableUtil default httpJsonGet: urlString.
	self assert: (resp code = 200)