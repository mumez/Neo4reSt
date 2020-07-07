actions-http-helper
httpJsonPost: urlOrString on: anHttpClient
	| urlString withStreamingOrNot resp |
	self httpSetAuthenticationInfoTo: anHttpClient.
	urlString := self stringFrom: urlOrString.
	withStreamingOrNot := self settings useStreaming.
	resp := anHttpClient jsonPost: urlString withStreaming: withStreamingOrNot.
	^ resp code = 401 ifTrue: [
		self httpSetAuthenticationInfoTo: anHttpClient. 
		anHttpClient jsonPost: urlString  withStreaming: withStreamingOrNot.
	] ifFalse: [ 
		resp
	]
