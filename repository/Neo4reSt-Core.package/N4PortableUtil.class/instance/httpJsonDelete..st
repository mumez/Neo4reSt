actions-http
httpJsonDelete: urlString
	^ self httpClientDo: [ :cli | self httpJsonDelete: urlString on: cli ]