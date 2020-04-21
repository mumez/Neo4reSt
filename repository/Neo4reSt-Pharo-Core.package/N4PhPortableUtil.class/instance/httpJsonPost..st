actions-http
httpJsonPost: urlString
	| json withStreamingOrNot resp |
	self httpSetAuthenticationInfo.
	json := self stringFrom: urlString.
	withStreamingOrNot := self settings useStreaming.
	resp := self httpClient jsonPost: json withStreaming: withStreamingOrNot.
	^ resp code = 401 ifTrue: [
		self httpSetAuthenticationInfo. 
		self httpClient jsonPost: json  withStreaming: withStreamingOrNot.
	] ifFalse: [ 
		resp
	]
