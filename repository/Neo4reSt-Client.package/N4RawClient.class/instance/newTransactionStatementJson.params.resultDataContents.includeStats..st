builder
newTransactionStatementJson: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean
	| jsonDict |
	jsonDict := Dictionary new.
	jsonDict at: 'statement' put: queryString.
	dictionary isEmptyOrNil ifFalse: [jsonDict at: 'parameters' put: dictionary asDictionary].
	resultDataContents isEmptyOrNil ifFalse: [jsonDict at: 'resultDataContents' put: resultDataContents].
	aBoolean isNil ifFalse: [jsonDict at: 'includeStats' put: aBoolean].
	^jsonDict