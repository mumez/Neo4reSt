actions-http
httpJsonGet: urlString
	| resp |
	resp := self httpClient jsonGet: (self stringFrom: urlString).
	self signalErrorBasedOn: resp.
	^ resp