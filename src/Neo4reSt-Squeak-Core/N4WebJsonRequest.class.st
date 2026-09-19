Class {
	#name : #N4WebJsonRequest,
	#superclass : #WebRequest,
	#category : 'Neo4reSt-Squeak-Core'
}

{ #category : #initialize }
N4WebJsonRequest >> forSendData [
	self headerAt: 'Content-Type' put: 'application/json; charset=utf-8'.
]

{ #category : #initialize }
N4WebJsonRequest >> initialize [
	super initialize.
	self headerAt: 'Accept' put: 'application/json'.
]

{ #category : #initialize }
N4WebJsonRequest >> newResponse [
	"Create a new response entitiy.
	Subclasses can override this method to provide a different response class"

	^(N4WebJsonResponse new)
		request: self;
		yourself
]
