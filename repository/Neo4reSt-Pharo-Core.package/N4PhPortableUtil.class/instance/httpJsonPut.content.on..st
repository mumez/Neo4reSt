actions-http-helper
httpJsonPut: urlOrString content: jsonString on: anHttpClient
	| resp urlString |
	self httpSetAuthenticationInfoTo: anHttpClient.
	urlString := self stringFrom: urlOrString.
	resp := anHttpClient jsonPut: urlString content: jsonString.
	^ resp code = 401 ifTrue: [
		self httpSetAuthenticationInfoTo: anHttpClient.
		anHttpClient jsonPut: urlString content: jsonString.
	] ifFalse: [ 
		resp
	]