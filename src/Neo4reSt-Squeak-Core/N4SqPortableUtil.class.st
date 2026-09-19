Class {
	#name : #N4SqPortableUtil,
	#superclass : #N4PortableUtil,
	#instVars : [
		'httpClient'
	],
	#category : 'Neo4reSt-Squeak-Core'
}

{ #category : #'class initialization' }
N4SqPortableUtil class >> initialize [
	self activate
]

{ #category : #converting }
N4SqPortableUtil >> convertToNative: value using: settings [
	value isString ifTrue: [^ self nativeStringFrom: value].
	^value
]

{ #category : #factories }
N4SqPortableUtil >> createHttpClient [
	^WebClient new
]

{ #category : #accessing }
N4SqPortableUtil >> ensuredHttpClient [
	(httpClient notNil and: [httpClient isConnected not]) ifTrue: [self releaseHttpClient].
	httpClient ifNil: [httpClient := self createHttpClient].
	^httpClient
	
]

{ #category : #actions }
N4SqPortableUtil >> getJsonFrom: urlString [ 
	| response |
	response := self httpJsonGet: urlString.
	^self readJsonFromResponse: response
]

{ #category : #accessing }
N4SqPortableUtil >> httpClient [
	^  N4Settings default keepConnection
		ifTrue: [self ensuredHttpClient]
		ifFalse: [self createHttpClient]
]

{ #category : #accessing }
N4SqPortableUtil >> httpClient: anObject [
	"Set the value of httpClient"

	httpClient := anObject
]

{ #category : #'actions-http' }
N4SqPortableUtil >> httpJsonDelete: urlString [ 
	| resp |
	resp := self httpClient jsonDelete: (self stringFrom: urlString).
	resp code = 409 ifTrue: [^N4CannotDelete response: resp].
	^ resp
]

{ #category : #'actions-http' }
N4SqPortableUtil >> httpJsonGet: urlString [
	| resp |
	resp := self httpClient jsonGet: (self stringFrom: urlString).
	self signalErrorBasedOn: resp.
	^ resp
]

{ #category : #'actions-http' }
N4SqPortableUtil >> httpJsonPost: urlString [
	
	^ self httpClient jsonPost: (self stringFrom: urlString)
]

{ #category : #'actions-http' }
N4SqPortableUtil >> httpJsonPost: urlString content: jsonString [
	
	^ self httpClient jsonPost: (self stringFrom: urlString) content: jsonString
]

{ #category : #'actions-http' }
N4SqPortableUtil >> httpJsonPut: urlString content: jsonString [
	
	^ self httpClient jsonPut: (self stringFrom: urlString) content: jsonString
]

{ #category : #'read/write' }
N4SqPortableUtil >> jsonStringFrom: valueOrAssocs [ 
	| rawJsonString param |
	((valueOrAssocs isArray or: [valueOrAssocs class = OrderedCollection])
		and: [valueOrAssocs notEmpty and: [valueOrAssocs first isKindOf: Association]])
		ifTrue: [param := self dictionaryFromAssociations: valueOrAssocs]
		ifFalse: [param := valueOrAssocs].
	rawJsonString := Json render: param.
	^ self utf8StringFrom: rawJsonString
]

{ #category : #'read/write' }
N4SqPortableUtil >> nativeStringFrom: utf8String [
	^ utf8String utf8ToSqueak 
]

{ #category : #actions }
N4SqPortableUtil >> postJsonTo: urlString [
	^self readJsonFrom: (self httpJsonPost: urlString) contentStream
]

{ #category : #'read/write' }
N4SqPortableUtil >> readJsonFrom: aStream [

	^ Json readFrom: aStream
]

{ #category : #actions }
N4SqPortableUtil >> readJsonFromResponse: httpResponse [
	| strm |
	"strm := (httpResponse headerAt: 'transfer-encoding') = 'chunked' ifTrue: [httpResponse content readStream] ifFalse: [httpResponse contentStream]."
	strm := httpResponse content readStream.
	^ self readJsonFrom: strm
]

{ #category : #releasing }
N4SqPortableUtil >> release [
	self releaseHttpClient
]

{ #category : #releasing }
N4SqPortableUtil >> releaseHttpClient [
	httpClient ifNotNil: [httpClient destroy].
	httpClient := nil
]

{ #category : #'error handling' }
N4SqPortableUtil >> signalErrorBasedOn: response [
	| code |
	code := response code.
	(code between: 200 and: 203) ifTrue: [^self].
	code = 204 ifTrue: [^ (N4NoContent response: response) signal].
	code = 404
		ifTrue: [^ (N4NotFound response: response) signal].
	^ (N4Error response: response) signal
]

{ #category : #'misc utils' }
N4SqPortableUtil >> string: aString beginsWith: prefix [ 
	^ aString beginsWith: prefix 
]

{ #category : #'read/write' }
N4SqPortableUtil >> utf8StringFrom: squeakString [
	^ squeakString squeakToUtf8 
]
