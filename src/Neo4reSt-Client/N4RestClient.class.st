Class {
	#name : 'N4RestClient',
	#superclass : 'Object',
	#instVars : [
		'rawClient',
		'settings'
	],
	#category : 'Neo4reSt-Client',
	#package : 'Neo4reSt-Client'
}

{ #category : 'instance creation' }
N4RestClient class >> rootUri: rootUri [
	^ self new rootUri: rootUri; yourself
]

{ #category : 'instance creation' }
N4RestClient class >> settings: aN4Settings [
	| inst |
	inst := self new.
	inst applySettings: aN4Settings.
	^inst
]

{ #category : 'actions-labels' }
N4RestClient >> addLabel: label nodeAt: nodeId [
	|  resp |
	resp := self rawClient addLabel: label nodeAt: nodeId.
	^ resp code ~= 404
]

{ #category : 'actions-labels' }
N4RestClient >> addLabels: labels nodeAt: nodeId [
	|  resp |
	resp := self rawClient addLabels: labels nodeAt: nodeId.
	^ resp code ~= 404
]

{ #category : 'actions-indexers' }
N4RestClient >> addNodeIndex: indexName on: nodeUri key: key value: value [
	^self rawClient addNodeIndex: indexName on: nodeUri key: key value: value
]

{ #category : 'actions-indexers' }
N4RestClient >> addRelationshipIndex: indexName on: nodeUri key: key value: value [
	^self rawClient addRelationshipIndex: indexName on: nodeUri key: key value: value
]

{ #category : 'initialization' }
N4RestClient >> applySettings: aNgSettings [
	self settings: aNgSettings.
	self rawClient settings: aNgSettings.
]

{ #category : 'releasing' }
N4RestClient >> close [
	self rawClient ifNotNil: [:cli | cli release]
	
]

{ #category : 'actions' }
N4RestClient >> createNode [
	^ self rawClient createNode
]

{ #category : 'actions' }
N4RestClient >> createNode: properties [
	| props |
	props := N4PortableUtil default asProperties: properties.
	^self rawClient createNode: props
]

{ #category : 'actions' }
N4RestClient >> createRelationshipAt: nodeId to: uri type: type [
	^self rawClient createRelationshipAt: nodeId to: uri type: type
]

{ #category : 'actions' }
N4RestClient >> createRelationshipAt: nodeId to: uri type: type properties: properties [
	| props |
	props := N4PortableUtil default asProperties: properties.
	^self rawClient createRelationshipAt: nodeId to: uri type: type properties: props
]

{ #category : 'actions-labels' }
N4RestClient >> deleteLabel: label nodeAt: nodeId [
	| response |
	response := self rawClient deleteLabel: label nodeAt: nodeId.
	^ response code = 204
]

{ #category : 'actions' }
N4RestClient >> deleteNodeAt: id [ 
	| response |
	response := self rawClient deleteNodeAt: id.
	^ response code = 204
]

{ #category : 'actions' }
N4RestClient >> deleteNodeIndex: indexName [
	^ self rawClient deleteNodeIndex: indexName
]

{ #category : 'actions-indexers' }
N4RestClient >> deleteNodeIndexes: indexName [
	^ self rawClient deleteNodeIndexes: indexName
]

{ #category : 'actions' }
N4RestClient >> deletePropertiesNodeAt: nodeId [ 
	| response |
	response := self rawClient deletePropertiesNodeAt: nodeId.
	^ response code = 204
]

{ #category : 'actions' }
N4RestClient >> deletePropertiesRelationshipAt: relId [ 
	| response |
	response := self rawClient deletePropertiesRelationshipAt: relId.
	^ response code = 204
]

{ #category : 'actions' }
N4RestClient >> deleteProperty: propName nodeAt: nodeId [ 
	| response |
	response := self rawClient deleteProperty: propName nodeAt: nodeId.
	^ response code = 204
]

{ #category : 'actions' }
N4RestClient >> deleteProperty: propName relationshipAt: relId [ 
	| response |
	response := self rawClient deleteProperty: propName relationshipAt: relId.
	^ response code = 204
]

{ #category : 'actions' }
N4RestClient >> deleteRelationshipAt: id [ 
	| response |
	response := self rawClient deleteRelationshipAt: id.
	^ response code = 204
]

{ #category : 'actions' }
N4RestClient >> deleteRelationshipIndex: indexName [
	^ self rawClient deleteRelationshipIndex: indexName
]

{ #category : 'actions-indexers' }
N4RestClient >> deleteRelationshipIndexes: indexName [
	^ self rawClient deleteRelationshipIndexes: indexName
]

{ #category : 'actions' }
N4RestClient >> getAllRelationshipsAt: nodeId [
	^self rawClient getAllRelationshipsAt: nodeId
	
]

{ #category : 'actions' }
N4RestClient >> getAllRelationshipsAt: nodeId type: type [
	^self getAllRelationshipsAt: nodeId types: (Array with: type)
]

{ #category : 'actions' }
N4RestClient >> getAllRelationshipsAt: nodeId types: typeCollection [
	^self rawClient getAllRelationshipsAt: nodeId types: typeCollection
]

{ #category : 'actions' }
N4RestClient >> getBasicInformation [
	^ self rawClient getBasicInformation
]

{ #category : 'actions' }
N4RestClient >> getInRelationshipsAt: nodeId [
	^self rawClient getInRelationshipsAt: nodeId
]

{ #category : 'actions' }
N4RestClient >> getInRelationshipsAt: nodeId type: type [
	^self getInRelationshipsAt: nodeId types: (Array with: type)
]

{ #category : 'actions' }
N4RestClient >> getInRelationshipsAt: nodeId types: typeCollection [
	^self rawClient getInRelationshipsAt: nodeId types: typeCollection
]

{ #category : 'actions' }
N4RestClient >> getNodeAt: id [ 
	| resp |
	resp := self rawClient getNodeAt: id.
	^resp
]

{ #category : 'actions' }
N4RestClient >> getNodeIndexes [
	^ self rawClient getNodeIndexes
]

{ #category : 'actions-labels' }
N4RestClient >> getNodeLabelsAt: id [ 
	| resp |
	resp := self rawClient getNodeLabelsAt: id.
	^resp
]

{ #category : 'actions' }
N4RestClient >> getNodeWithIndex: indexName key: key value: value [
	^self rawClient getNodeWithIndex: indexName key: key value: value
]

{ #category : 'actions' }
N4RestClient >> getOutRelationshipsAt: nodeId [
	^self rawClient getOutRelationshipsAt: nodeId
]

{ #category : 'actions' }
N4RestClient >> getOutRelationshipsAt: nodeId type: type [
	^self getOutRelationshipsAt: nodeId types: (Array with: type)
]

{ #category : 'actions' }
N4RestClient >> getOutRelationshipsAt: nodeId types: typeCollection [
	^self rawClient getOutRelationshipsAt: nodeId types: typeCollection
]

{ #category : 'actions' }
N4RestClient >> getPropertiesNodeAt: nodeId [ 
	^ self rawClient getPropertiesNodeAt: nodeId 
]

{ #category : 'actions' }
N4RestClient >> getPropertiesRelationshipAt: relId [ 
	^ self rawClient getPropertiesRelationshipAt: relId 
]

{ #category : 'actions' }
N4RestClient >> getProperty: propName nodeAt: nodeId [
	^ self rawClient getProperty: propName nodeAt: nodeId
]

{ #category : 'actions' }
N4RestClient >> getProperty: propName relationshipAt: relId [
	^ self rawClient getProperty: propName relationshipAt: relId
]

{ #category : 'actions' }
N4RestClient >> getRelationshipAt: id [ 
	| resp |
	resp := self rawClient getRelationshipAt: id.
	^ resp
]

{ #category : 'actions' }
N4RestClient >> getRelationshipIndexes [
	^ self rawClient getRelationshipIndexes
]

{ #category : 'actions' }
N4RestClient >> getRelationshipTypes [
	^ self rawClient getRelationshipTypes
]

{ #category : 'actions' }
N4RestClient >> getRelationshipWithIndex: indexName key: key value: value [
	^self rawClient getRelationshipWithIndex: indexName key: key value: value
]

{ #category : 'actions' }
N4RestClient >> getRelationshipsAt: nodeId direction: direction types: typeCollection [
	^ self rawClient getRelationshipsAt: nodeId direction: direction types: typeCollection
]

{ #category : 'actions' }
N4RestClient >> getRoot [
	^self rawClient getRoot
]

{ #category : 'actions-query' }
N4RestClient >> graphByCypher: queryString params: dictionary [
	^self queryByCypher: queryString params: dictionary resultDataContents: #('graph') includeStats: nil
]

{ #category : 'builder' }
N4RestClient >> newCypher: queryString params: dictionary [
	^self newCypher: queryString params: dictionary resultDataContents: nil includeStats: nil
]

{ #category : 'builder' }
N4RestClient >> newCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean [
	^self rawClient newTransactionStatementJson: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean
]

{ #category : 'accessing' }
N4RestClient >> portableUtil [
	^self rawClient portableUtil
]

{ #category : 'actions-query' }
N4RestClient >> queryByCypher: queryString [
	^self queryByCypher: queryString params: nil resultDataContents: nil includeStats: nil
]

{ #category : 'actions-query' }
N4RestClient >> queryByCypher: queryString params: dictionary [
	^self queryByCypher: queryString params: dictionary resultDataContents: nil includeStats: nil
]

{ #category : 'actions-query' }
N4RestClient >> queryByCypher: queryString params: dictionary resultDataContents: resultDataContents [
	^self queryByCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: nil
]

{ #category : 'actions-query' }
N4RestClient >> queryByCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean [
	| resp |
	resp := self rawClient queryByCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean.
	^N4CypherResponse json: (self portableUtil readJsonFromResponse: resp)
]

{ #category : 'actions-multiple-query' }
N4RestClient >> queryByCyphers: queryStrings [
	^ self queryByCyphersWithParams: queryStrings
]

{ #category : 'actions-multiple-query' }
N4RestClient >> queryByCyphers: queryStrings arrayOfParams: arrayOfParams [
	^self queryByCyphersUsing: [:statements :builder |
		queryStrings with: arrayOfParams do: [ :queryString :params | 
			statements add: (self newCypher: queryString params: params).
		]
		statements
	]
]

{ #category : 'actions-multiple-query' }
N4RestClient >> queryByCyphersUsing: queryBuildingBlock [
	| resp |
	resp := self rawClient queryByCyphersUsing: queryBuildingBlock.
	^N4CypherResponse json: (self portableUtil readJsonFromResponse: resp)
]

{ #category : 'actions-multiple-query' }
N4RestClient >> queryByCyphersWithParams: queryWithParams [
	^self queryByCyphersUsing: [:statements :builder |
		queryWithParams do: [ :queryParamPair | 
			queryParamPair isString ifTrue: [  
				statements add: (self newCypher: queryParamPair params: #()).
			] ifFalse: [  
				statements add: (self newCypher: queryParamPair first params: queryParamPair second asDictionary).
			]
		].
		statements
	]
]

{ #category : 'actions-deprecated' }
N4RestClient >> queryByLegacyCypher: queryString [
	| resp |
	resp := self rawClient queryByLegacyCypher: queryString.
	^self portableUtil readJsonFromResponse: resp
]

{ #category : 'actions-deprecated' }
N4RestClient >> queryByLegacyCypher: queryString params: dictionary [
	| resp |
	resp := self rawClient queryByLegacyCypher: queryString params: dictionary.
	^self portableUtil readJsonFromResponse: resp
]

{ #category : 'accessing' }
N4RestClient >> rawClient [

	^ rawClient ifNil: [rawClient := N4RawClient new]
]

{ #category : 'accessing' }
N4RestClient >> rawClient: anObject [
	"Set the value of rawClient"

	rawClient := anObject
]

{ #category : 'actions-indexers' }
N4RestClient >> removeNodeIndexes: indexName on: nodeId [
	^ self rawClient removeNodeIndexes: indexName on: nodeId
]

{ #category : 'actions-indexers' }
N4RestClient >> removeNodeIndexes: indexName on: nodeId key: key [
	^ self rawClient removeNodeIndexes: indexName on: nodeId key: key
]

{ #category : 'actions-indexers' }
N4RestClient >> removeNodeIndexes: indexName on: nodeId key: key value: value [
	^ self rawClient removeNodeIndexes: indexName on: nodeId key: key value: value
]

{ #category : 'actions-indexers' }
N4RestClient >> removeRelationshipIndexes: indexName on: nodeId [
	^ self rawClient removeRelationshipIndexes: indexName on: nodeId
]

{ #category : 'actions-indexers' }
N4RestClient >> removeRelationshipIndexes: indexName on: nodeId key: key [
	^ self rawClient removeRelationshipIndexes: indexName on: nodeId key: key
]

{ #category : 'actions-indexers' }
N4RestClient >> removeRelationshipIndexes: indexName on: nodeId key: key value: value [
	^ self rawClient removeRelationshipIndexes: indexName on: nodeId key: key value: value
]

{ #category : 'accessing' }
N4RestClient >> rootUri [
	^ self rawClient rootUri
]

{ #category : 'accessing' }
N4RestClient >> rootUri: uriString [
	self rawClient rootUri: uriString
]

{ #category : 'actions-labels' }
N4RestClient >> setLabels: labels nodeAt: nodeId [
	|  resp |
	resp := self rawClient setLabels: labels nodeAt: nodeId.
	^ resp code ~= 404
]

{ #category : 'actions' }
N4RestClient >> setProperties: properties nodeAt: nodeId [
	| props resp |
	props := N4PortableUtil default asProperties: properties.
	resp := self rawClient setProperties: props nodeAt: nodeId.
	^ resp code ~= 404
]

{ #category : 'actions' }
N4RestClient >> setProperties: properties relationshipAt: relId [
	| props resp |
	props := N4PortableUtil default asProperties: properties.
	resp := self rawClient setProperties: props relationshipAt: relId.
	^ resp code ~= 404
]

{ #category : 'actions' }
N4RestClient >> setProperty: propName to: value nodeAt: nodeId [ 
	| resp |
	resp := self rawClient setProperty: propName to: value nodeAt: nodeId.
	^ resp code ~= 404
]

{ #category : 'actions' }
N4RestClient >> setProperty: propName to: value relationshipAt: relId [ 
	| resp |
	resp := self rawClient setProperty: propName to: value relationshipAt: relId.
	^ resp code ~= 404
]

{ #category : 'accessing' }
N4RestClient >> settings [
	settings ifNil: [ settings := N4Settings default ].
	^ settings
]

{ #category : 'accessing' }
N4RestClient >> settings: anObject [

	settings := anObject
]

{ #category : 'actions' }
N4RestClient >> traverseFrom: nodeId using: traversalDescription [
	| resp |
	resp := self rawClient traverseFrom: nodeId using: traversalDescription.
	^self portableUtil readJsonFromResponse: resp

]
