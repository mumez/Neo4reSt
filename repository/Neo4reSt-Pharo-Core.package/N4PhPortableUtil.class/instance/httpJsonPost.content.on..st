actions-http-helper
httpJsonPost: urlOrString content: jsonString on: anHttpClient
	| urlString withStreamingOrNot resp |
	self httpSetAuthenticationInfoTo: anHttpClient.
	urlString := self stringFrom: urlOrString.
	withStreamingOrNot := self settings useStreaming.
	resp := anHttpClient jsonPost: urlString content: jsonString withStreaming: withStreamingOrNot.
	^ resp code = 401 ifTrue: [
		self httpSetAuthenticationInfoTo: anHttpClient.
		anHttpClient jsonPost: urlString content: jsonString withStreaming: withStreamingOrNot.
	] ifFalse: [ 
		resp
	]