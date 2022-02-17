actions-query
queryByCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean
	"execute a query, and commit with just a single HTTP request"
	| statementDict json jsonString |
	statementDict := self newTransactionStatementJson: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean.
	json := self newTransactionStatementsJson: {statementDict}.
	jsonString := self portableUtil jsonStringFrom: json.
	^ self portableUtil httpJsonPost: self transactionUri content: jsonString