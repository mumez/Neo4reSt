logging
startLoggingToTranscript
	self logger: [ :loggedTuple | Transcript crShow: {#N4GraphDb. loggedTuple} ]