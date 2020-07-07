actions-http-helper
httpJsonDelete: urlString on: anHttpClient 
	| resp json |
	self httpSetAuthenticationInfoTo: anHttpClient.
	json := self stringFrom: urlString.
	resp := anHttpClient jsonDelete: json.
	resp code = 401 ifTrue: [
		self httpSetAuthenticationInfoTo: anHttpClient. 
		resp := anHttpClient jsonDelete: json].
	resp code = 409 ifTrue: [^ N4CannotDelete response: resp].
	^ resp