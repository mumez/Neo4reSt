Class {
	#name : 'N4PhPortableUtil',
	#superclass : 'N4PortableUtil',
	#instVars : [
		'httpClient'
	],
	#category : 'Neo4reSt-Pharo-Core',
	#package : 'Neo4reSt-Pharo-Core'
}

{ #category : 'class initialization' }
N4PhPortableUtil class >> initialize [
	self activate
]

{ #category : 'converting' }
N4PhPortableUtil >> convertToNative: value using: settingsDict [
	"Zinc automatically decode value, so this is not needed anymore"
	"value isString ifTrue: [^ self nativeStringFrom: value]."
	^value

]

{ #category : 'actions-http-helper' }
N4PhPortableUtil >> createHttpClient [
	| cli |
	cli := ZnClient new.
	self settings keepConnection ifFalse: [ cli beOneShot ].
	^cli
]

{ #category : 'converting' }
N4PhPortableUtil >> dictionaryFromAssociations: assocs [
	^ assocs asDictionary
	
]

{ #category : 'actions' }
N4PhPortableUtil >> getJsonFrom: urlString [ 
	| response |
	response := self httpJsonGet: urlString.
	^self readJsonFromResponse: response
]

{ #category : 'actions-http-helper' }
N4PhPortableUtil >> httpJsonDelete: urlString on: anHttpClient [ 
	| resp json |
	self httpSetAuthenticationInfoTo: anHttpClient.
	json := self stringFrom: urlString.
	resp := anHttpClient jsonDelete: json.
	resp code = 401 ifTrue: [
		self httpSetAuthenticationInfoTo: anHttpClient. 
		resp := anHttpClient jsonDelete: json].
	resp code = 409 ifTrue: [^ N4CannotDelete response: resp].
	^ resp
]

{ #category : 'actions-http-helper' }
N4PhPortableUtil >> httpJsonGet: urlOrString on: anHttpClient [
	| resp urlString |
	self httpSetAuthenticationInfoTo: anHttpClient.
	urlString := self stringFrom: urlOrString.
	resp := anHttpClient jsonGet: urlString.
	resp code = 401 ifTrue: [
		self httpSetAuthenticationInfoTo: anHttpClient. 
		resp := anHttpClient jsonGet: urlString].
	self signalErrorBasedOn: resp.
	^ resp
]

{ #category : 'actions-http-helper' }
N4PhPortableUtil >> httpJsonPost: urlOrString content: jsonString on: anHttpClient [
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
]

{ #category : 'actions-http-helper' }
N4PhPortableUtil >> httpJsonPost: urlOrString on: anHttpClient [
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

]

{ #category : 'actions-http-helper' }
N4PhPortableUtil >> httpJsonPut: urlOrString content: jsonString on: anHttpClient [
	| resp urlString |
	self httpSetAuthenticationInfoTo: anHttpClient.
	urlString := self stringFrom: urlOrString.
	resp := anHttpClient jsonPut: urlString content: jsonString.
	^ resp code = 401 ifTrue: [
		self httpSetAuthenticationInfoTo: anHttpClient.
		anHttpClient jsonPut: urlString content: jsonString.
	] ifFalse: [ 
		resp
	]
]

{ #category : 'actions-http-helper' }
N4PhPortableUtil >> httpSetAuthenticationInfoTo: anHtpClient [
	| se |
	(se := self settings) useAuthentication ifFalse: [^self].
	anHtpClient username: se username password: se password
]

{ #category : 'read/write' }
N4PhPortableUtil >> jsonStringFrom: valueOrAssocs [ 
	| dict rawJsonString param |
	((valueOrAssocs isArray or: [valueOrAssocs class = OrderedCollection])
		and: [valueOrAssocs notEmpty and: [valueOrAssocs first isKindOf: Association]])
		ifTrue: [dict := valueOrAssocs asDictionary.
			param := dict]
		ifFalse: [param := valueOrAssocs].
	rawJsonString := NeoJSONWriter toString: param.
	^ rawJsonString
]

{ #category : 'actions' }
N4PhPortableUtil >> postJson: json to: urlString [

	
]

{ #category : 'actions' }
N4PhPortableUtil >> postJsonTo: urlString [
	^self readJsonFrom: (self httpJsonPost: urlString) contentStream
]

{ #category : 'read/write' }
N4PhPortableUtil >> readJsonFrom: aStream [
	^ (NeoJSONReader on: aStream) next
]

{ #category : 'actions' }
N4PhPortableUtil >> readJsonFromResponse: httpResponse [
	| strm |
	strm := httpResponse contents readStream.
	^ self readJsonFrom: strm
]

{ #category : 'error handling' }
N4PhPortableUtil >> signalErrorBasedOn: response [
	| code |
	code := response code.
	(code between: 200 and: 203) ifTrue: [^self].
	code = 204 ifTrue: [^ (N4NoContent response: response) signal].
	code = 404
		ifTrue: [^ (N4NotFound response: response) signal].
	^ (N4Error response: response) signal
]

{ #category : 'misc utils' }
N4PhPortableUtil >> string: aString beginsWith: prefix [ 
	^ aString beginsWith: prefix 
]
