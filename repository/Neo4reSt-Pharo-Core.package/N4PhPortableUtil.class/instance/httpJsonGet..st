actions-http
httpJsonGet: urlString
	| resp json |
	self httpSetAuthenticationInfo.
	json := self stringFrom: urlString.
	resp := self httpClient jsonGet: json.
	resp code = 401 ifTrue: [
		self httpSetAuthenticationInfo. 
		resp := self httpClient jsonGet: json].
	self signalErrorBasedOn: resp.
	^ resp