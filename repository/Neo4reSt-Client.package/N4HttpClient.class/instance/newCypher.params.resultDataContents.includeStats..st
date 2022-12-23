builder
newCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean
	^self rawClient newTransactionStatementJson: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean