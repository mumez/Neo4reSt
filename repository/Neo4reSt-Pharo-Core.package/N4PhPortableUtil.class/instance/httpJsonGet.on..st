actions-http-helper
httpJsonGet: urlOrString on: anHttpClient
	| resp urlString |
	self httpSetAuthenticationInfoTo: anHttpClient.
	urlString := self stringFrom: urlOrString.
	resp := anHttpClient jsonGet: urlString.
	resp code = 401 ifTrue: [
		self httpSetAuthenticationInfoTo: anHttpClient. 
		resp := anHttpClient jsonGet: urlString].
	self signalErrorBasedOn: resp.
	^ resp