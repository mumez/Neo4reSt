accessing
transactionUri
	transactionUri ifNil: [ transactionUri := self prepareTransactionUrl ].
	^ transactionUri