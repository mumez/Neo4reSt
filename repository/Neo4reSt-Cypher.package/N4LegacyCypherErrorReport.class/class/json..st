instance creation
json: jsonObject
	| inst |
	inst := self new.
	inst message: (jsonObject at: 'message').
	inst exception: (jsonObject at: 'exception').
	inst stackTrace: (jsonObject at: 'stackTrace').
	^inst