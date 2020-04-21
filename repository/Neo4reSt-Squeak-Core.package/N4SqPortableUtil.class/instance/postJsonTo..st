actions
postJsonTo: urlString
	^self readJsonFrom: (self httpJsonPost: urlString) contentStream