testing
testPost
	| resp urlString |
	urlString := 'http://localhost:7474/db/data/'.
	resp := N4PortableUtil default httpJsonPost: urlString.
	self assert: (resp code = 405) "POST not allowed"