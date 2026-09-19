Class {
	#name : 'N4BasicHttpTest',
	#superclass : 'TestCase',
	#category : 'Neo4reSt-Tests',
	#package : 'Neo4reSt-Tests'
}

{ #category : 'accessing' }
N4BasicHttpTest >> newHttpClient [
	^ N4HttpClient new settings: N4GraphDbTest defaultSettings
]

{ #category : 'testing' }
N4BasicHttpTest >> testGet [
	| cli resp urlString |
	cli := self newHttpClient.
	urlString := cli rootUri.
	resp := cli portableUtil httpJsonGet: urlString.
	self assert: resp code equals: 200
]

{ #category : 'testing' }
N4BasicHttpTest >> testGetBasicInformation [
	| client info |
	client := self newHttpClient.
	info := client getBasicInformation.
	self assert: (info includesKey: 'neo4j_version')
]
