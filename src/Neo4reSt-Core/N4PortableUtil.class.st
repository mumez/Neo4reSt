Class {
	#name : 'N4PortableUtil',
	#superclass : 'Object',
	#instVars : [
		'settings'
	],
	#classVars : [
		'ActualClass'
	],
	#classInstVars : [
		'default'
	],
	#category : 'Neo4reSt-Core',
	#package : 'Neo4reSt-Core'
}

{ #category : 'private' }
N4PortableUtil class >> activate [
	ActualClass := self.
	^ActualClass
]

{ #category : 'instance creation' }
N4PortableUtil class >> default [
	default ifNil: [default := self defaultClass new].
	^ default
]

{ #category : 'instance creation' }
N4PortableUtil class >> defaultClass [
	ActualClass ifNil: [ActualClass := ((N4PortableUtil subclasses at: 1) activate)].
	^ ActualClass
]

{ #category : 'class initialization' }
N4PortableUtil class >> initDefault [
	default := nil
]

{ #category : 'class initialization' }
N4PortableUtil class >> initialize [
	"override"
]

{ #category : 'converting' }
N4PortableUtil >> asProperties: someProps [

	^someProps isArray ifTrue: [someProps] ifFalse: [Array with: someProps].
]

{ #category : 'converting' }
N4PortableUtil >> convertToNative: value using: settingsDict [
	^value
]

{ #category : 'actions-http-helper' }
N4PortableUtil >> createHttpClient [
]

{ #category : 'actions' }
N4PortableUtil >> deleteJsonFrom: urlString [ 
]

{ #category : 'converting' }
N4PortableUtil >> dictionaryFromAssociations: assocs [
	| dict |
	dict := Dictionary new: assocs size.
	dict addAll: assocs.
	^ dict
]

{ #category : 'actions' }
N4PortableUtil >> firstOrNilOf: aCollection [
	aCollection isEmpty ifTrue: [^nil].
	^ aCollection first
]

{ #category : 'actions' }
N4PortableUtil >> getJsonFrom: urlString [

	
]

{ #category : 'actions' }
N4PortableUtil >> getJsonOrEmptyFrom: urlString [

	^[self getJsonFrom: urlString]
		on: N4NoContent
		do: [:ex | ex return: #()]
]

{ #category : 'actions-http-helper' }
N4PortableUtil >> httpClientDo: aBlock [
	^ aBlock value: self createHttpClient.
	
]

{ #category : 'actions-http' }
N4PortableUtil >> httpJsonDelete: urlString [
	^ self httpClientDo: [ :cli | self httpJsonDelete: urlString on: cli ]
]

{ #category : 'actions-http-helper' }
N4PortableUtil >> httpJsonDelete: urlString on: anHttpClient [
]

{ #category : 'actions-http' }
N4PortableUtil >> httpJsonGet: urlString [
	^ self httpClientDo: [ :cli | self httpJsonGet: urlString on: cli]
]

{ #category : 'actions-http-helper' }
N4PortableUtil >> httpJsonGet: urlString on: anHttpClient [

]

{ #category : 'actions-http' }
N4PortableUtil >> httpJsonPost: urlString [
	^ self httpClientDo: [ :cli | self httpJsonPost: urlString on: cli ]
]

{ #category : 'actions-http' }
N4PortableUtil >> httpJsonPost: urlString content: jsonString [
	^ self httpClientDo: [ :cli | self httpJsonPost: urlString content: jsonString on: cli ]
]

{ #category : 'actions-http-helper' }
N4PortableUtil >> httpJsonPost: urlString content: jsonString on: anHttpClient [
	
	
]

{ #category : 'actions-http-helper' }
N4PortableUtil >> httpJsonPost: urlString on: anHttpClient [
	
	
]

{ #category : 'actions-http' }
N4PortableUtil >> httpJsonPut: urlString content: jsonString [
	^ self httpClientDo: [ :cli | self httpJsonPut: urlString content: jsonString on: cli ]
]

{ #category : 'actions-http-helper' }
N4PortableUtil >> httpJsonPut: urlString content: jsonString on: anHttpClient [
]

{ #category : 'read/write' }
N4PortableUtil >> jsonStringFrom: assocs [
	
]

{ #category : 'read/write' }
N4PortableUtil >> pickIdFrom: uriString [ 
	"N4SqPortableUtil default pickIdFrom: 'http://localhost:7474/db/data/node/10'"
	"N4SqPortableUtil default pickIdFrom: 'http://localhost:7474/db/'"
	| sz |
	(sz := uriString size)
		to: 1
		by: -1
		do: [:idx | $/ = (uriString at: idx)
				ifTrue: [| chopped |
					chopped := uriString copyFrom: idx + 1 to: sz.
					^ chopped isEmpty
						ifTrue: [0]
						ifFalse: [chopped asInteger]]].
	^ -1
]

{ #category : 'actions' }
N4PortableUtil >> postJson: json to: urlString [

	
]

{ #category : 'actions' }
N4PortableUtil >> postJsonTo: urlString [
	
]

{ #category : 'read/write' }
N4PortableUtil >> readJsonFrom: aStream [

	
]

{ #category : 'read/write' }
N4PortableUtil >> readJsonFromResponse: httpResponse [
]

{ #category : 'releasing' }
N4PortableUtil >> release [
]

{ #category : 'accessing' }
N4PortableUtil >> settings [
	^ settings ifNil: [settings := N4Settings default]
]

{ #category : 'accessing' }
N4PortableUtil >> settings: aSettings [
	settings := aSettings 
]

{ #category : 'error handling' }
N4PortableUtil >> signalErrorBasedOn: response [ 
]

{ #category : 'misc utils' }
N4PortableUtil >> string: aString beginsWith: prefix [ 
	^ (prefix, '*') match: aString
]

{ #category : 'converting' }
N4PortableUtil >> stringFrom: anObject [
	^ anObject asString
]

{ #category : 'converting' }
N4PortableUtil >> urlEncodedStringFrom: anObject [
	"By default - just escape slash - mostly we can leave full url encoding to the underlying http client"
	| str |
	str := self stringFrom: anObject.
	^str copyReplaceAll: '/' with: '%2F'
]
