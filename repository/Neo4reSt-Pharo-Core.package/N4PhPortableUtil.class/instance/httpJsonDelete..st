actions-http
httpJsonDelete: urlString 
	| resp json |
	self httpSetAuthenticationInfo.
	json := self stringFrom: urlString.
	resp := self httpClient jsonDelete: json.
	resp code = 401 ifTrue: [
		self httpSetAuthenticationInfo. 
		resp := self httpClient jsonDelete: json].
	resp code = 409 ifTrue: [^ N4CannotDelete response: resp].
	^ resp