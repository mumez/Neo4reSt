default
defaultDescription

	messageText ifNil: [ self extractMessageTextFromResponse ].
	^ super defaultDescription