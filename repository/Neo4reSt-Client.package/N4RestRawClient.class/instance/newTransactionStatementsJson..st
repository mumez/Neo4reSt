builder
newTransactionStatementsJson: statementDictionaries
	| dict |
	dict := Dictionary new.
	dict at: 'statements' put: statementDictionaries.
	^dict