error handling
signalErrorBasedOn: response
	| code |
	code := response code.
	(code between: 200 and: 203) ifTrue: [^self].
	code = 204 ifTrue: [^ (N4NoContent response: response) signal].
	code = 404
		ifTrue: [^ (N4NotFound response: response) signal].
	^ (N4Error response: response) signal