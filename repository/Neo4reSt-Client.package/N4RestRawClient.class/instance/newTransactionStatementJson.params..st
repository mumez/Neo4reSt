builder
newTransactionStatementJson: queryString params: dictionary
	^self newTransactionStatementJson: queryString params: dictionary resultDataContents: nil includeStats: nil