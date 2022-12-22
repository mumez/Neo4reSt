actions-cypher
runCyphersBy: aStatementsAppenderBlock
	| appender |
	appender := N4CypherStatementAppender new.
	aStatementsAppenderBlock value: appender.
	^self queryByCyphersWithArguments: appender cyphersWithArguments