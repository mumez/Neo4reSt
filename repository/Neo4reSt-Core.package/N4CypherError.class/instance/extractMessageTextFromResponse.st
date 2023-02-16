default
extractMessageTextFromResponse

	| resp |
	resp := self response.
	resp ifNil: [ ^ self ].
	messageText := resp errors first at: 'message' ifAbsent: [  ]