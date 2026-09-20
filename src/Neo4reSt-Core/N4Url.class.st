Class {
	#name : 'N4Url',
	#superclass : 'Object',
	#instVars : [
		'baseUrlString',
		'components'
	],
	#category : 'Neo4reSt-Core',
	#package : 'Neo4reSt-Core'
}

{ #category : 'instance creation' }
N4Url class >> baseUrlString: baseUrlString [
	^self new baseUrlString: baseUrlString
]

{ #category : 'concatenating' }
N4Url >> , pathConponent [
	^(self class baseUrlString: self asString) // pathConponent
]

{ #category : 'concatenating' }
N4Url >> / stringPathComponent [
	self components add: (self portableUtil stringFrom: stringPathComponent)
]

{ #category : 'concatenating' }
N4Url >> // pathComponent [
	self components add: (self portableUtil urlEncodedStringFrom: pathComponent)
]

{ #category : 'converting' }
N4Url >> asString [
	| stream |
	self components isEmpty ifTrue: [^self baseUrlString].
	stream := WriteStream with: self baseUrlString.
	self components do: [:each | stream nextPutAll: each] separatedBy: [stream nextPut: $/].
	^stream contents
]

{ #category : 'accessing' }
N4Url >> baseUrlString [
	^ baseUrlString ifNil: [baseUrlString := '']
]

{ #category : 'accessing' }
N4Url >> baseUrlString: anObject [
	| string |
	anObject ifNil: [^baseUrlString := nil].
	string := anObject last = $/ ifTrue: [anObject] ifFalse: [anObject, '/'].
	baseUrlString := string
]

{ #category : 'accessing' }
N4Url >> components [
	^ components ifNil: [components := OrderedCollection new]
]

{ #category : 'accessing' }
N4Url >> components: anObject [
	components := anObject
]

{ #category : 'accessing' }
N4Url >> portableUtil [
	^ N4PortableUtil default
]

{ #category : 'printing' }
N4Url >> printOn: aStream [
	aStream nextPutAll: self asString
]
