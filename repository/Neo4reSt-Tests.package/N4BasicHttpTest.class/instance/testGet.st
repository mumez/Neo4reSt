testing
testGet
	| cli resp urlString |
	cli := self newHttpClient.
	urlString := cli rootUri.
	resp := cli portableUtil httpJsonGet: urlString.
	self assert: resp code equals: 200