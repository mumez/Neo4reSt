logging
logInfo: anObject tag: tag
	self logger ifNotNil: [:lgr | lgr value: {#info. tag. anObject}]