actions-http
httpJsonPost: urlString content: jsonString
	| json withStreamingOrNot resp |
	self httpSetAuthenticationInfo.
	json := self stringFrom: urlString.
	withStreamingOrNot := self settings useStreaming.
	resp := self httpClient jsonPost: json content: jsonString withStreaming: withStreamingOrNot.
	^ resp code = 401 ifTrue: [
		self httpSetAuthenticationInfo.
		self httpClient jsonPost: json content: jsonString withStreaming: withStreamingOrNot.
	] ifFalse: [ 
		resp
	]