"
I perform the low-level HTTP requests against Neo4j's transaction/Cypher
endpoint and the legacy (deprecated) REST endpoints.

Responsibility:
- I build transaction statement JSON and POST it to the Cypher transaction
  endpoint, returning the raw HTTP response.
- I hold the rootUri, databaseName/transactionUri, and settings needed to
  address a specific Neo4j server and database.
- I delegate JSON encoding/decoding and the actual HTTP calls to my
  portableUtil.

Collaborators:
- N4PortableUtil (actually its Pharo subclass, N4PhPortableUtil): performs
  the platform HTTP calls and JSON (de)serialization; I hold one as
  portableUtil, created lazily on first use.
- N4HttpClient: my usual caller, which builds Cypher queries and interprets
  my responses as N4CypherResponse.

Public API and Key Messages:
- #queryByCypher:params:resultDataContents:includeStats: - run one statement.
- #queryByCyphersUsing: - run a block-built list of statements in one call.
- #close - releases my underlying HTTP connection, if one is held.

Implementation Points:
- #close reads portableUtil directly (not via the lazy self portableUtil
  accessor) so that closing a client that never ran a query does not
  create one first.
- My deprecated-* categories implement Neo4j's old non-transactional REST
  API and are kept only for backward compatibility.
"
Class {
	#name : 'N4RawClient',
	#superclass : 'Object',
	#instVars : [
		'rootUri',
		'portableUtil',
		'transactionUri',
		'databaseName',
		'settings'
	],
	#category : 'Neo4reSt-Client',
	#package : 'Neo4reSt-Client'
}

{ #category : 'instance creation' }
N4RawClient class >> rootUri: rootUri [
	^ self new rootUri: rootUri; yourself
]

{ #category : 'deprecated-labels' }
N4RawClient >> addLabel: label nodeAt: nodeId [
	| jsonString urlString |
	urlString := self nodeUri // nodeId / 'labels'.
	jsonString := self portableUtil jsonStringFrom: (Array with: label).
	^ self portableUtil httpJsonPost: urlString content: jsonString 
]

{ #category : 'deprecated-labels' }
N4RawClient >> addLabels: labels nodeAt: nodeId [
	| jsonString urlString |
	urlString := self nodeUri // nodeId / 'labels'.
	jsonString := self portableUtil jsonStringFrom: labels.
	^ self portableUtil httpJsonPost: urlString content: jsonString 
]

{ #category : 'deprecated-indexes' }
N4RawClient >> addNodeIndex: indexName on: nodeUri key: key value: value [
	|json jsonString |
	json := self newNodeIndexJson: nodeUri key: key value: value.
	jsonString := self portableUtil jsonStringFrom: json.
	^ self portableUtil httpJsonPost: (self indexUri / 'node' // indexName) content: jsonString
]

{ #category : 'deprecated-indexes' }
N4RawClient >> addRelationshipIndex: indexName on: relationshipUri key: key value: value [
	|json jsonString |
	json := self newRelationshipIndexJson: relationshipUri key: key value: value.
	jsonString := self portableUtil jsonStringFrom: json.
	^ self portableUtil httpJsonPost: (self indexUri / 'relationship' // indexName) content: jsonString
]

{ #category : 'initailization' }
N4RawClient >> applySettings: aNgSettings [
	self settings: aNgSettings.
	self portableUtil settings: aNgSettings
]

{ #category : 'releasing' }
N4RawClient >> close [
	"Reads the ivar directly (not self portableUtil) to avoid lazily creating one just to release it."
	portableUtil ifNotNil: [:util | util release]
]

{ #category : 'deprecated-rest' }
N4RawClient >> createNode [
	^ self portableUtil httpJsonPost: self nodeUri
]

{ #category : 'deprecated-rest' }
N4RawClient >> createNode: properties [
	| jsonString |
	jsonString := self portableUtil jsonStringFrom: properties.
	^ self portableUtil httpJsonPost: self nodeUri content: jsonString
]

{ #category : 'deprecated-rest' }
N4RawClient >> createRelationshipAt: nodeId to: uri type: type [
	^self createRelationshipAt: nodeId to: uri type: type properties: nil
]

{ #category : 'deprecated-rest' }
N4RawClient >> createRelationshipAt: nodeId to: uri type: type properties: assocs [
	|json jsonString |
	json := self newRelationshipJson: uri type: type asString properties: assocs.
	jsonString := self portableUtil jsonStringFrom: json.
	^ self portableUtil httpJsonPost: (self nodeUri // nodeId / 'relationships') content: jsonString
]

{ #category : 'accessing' }
N4RawClient >> databaseName [
	databaseName ifNil: [ databaseName := self settings databaseName ].
	^ databaseName
]

{ #category : 'accessing' }
N4RawClient >> databaseName: anObject [

	databaseName := anObject
]

{ #category : 'deprecated-labels' }
N4RawClient >> deleteLabel: label nodeAt: nodeId [
	|  urlString |
	urlString := self nodeUri // nodeId / 'labels' / label.
	^ self portableUtil httpJsonDelete: urlString
]

{ #category : 'deprecated-rest' }
N4RawClient >> deleteNodeAt: id [ 
	^ self portableUtil httpJsonDelete: self nodeUri // id
]

{ #category : 'deprecated-rest' }
N4RawClient >> deleteNodeIndex: indexName [
	^ self portableUtil httpJsonDelete: self indexUri / 'node' // indexName
]

{ #category : 'deprecated-indexes' }
N4RawClient >> deleteNodeIndexes: indexName [
	^ self portableUtil httpJsonDelete: self indexUri / 'node' // indexName 
]

{ #category : 'deprecated-rest' }
N4RawClient >> deletePropertiesNodeAt: nodeId [ 
	^ self portableUtil httpJsonDelete: self nodeUri // nodeId / 'properties'
]

{ #category : 'deprecated-rest' }
N4RawClient >> deletePropertiesRelationshipAt: relId [ 
	^ self portableUtil httpJsonDelete: self relationshipUri // relId asString / 'properties'
]

{ #category : 'deprecated-rest' }
N4RawClient >> deleteProperty: propName nodeAt: nodeId [ 
	^ self portableUtil httpJsonDelete: self nodeUri // nodeId / 'properties' // propName
]

{ #category : 'deprecated-rest' }
N4RawClient >> deleteProperty: propName relationshipAt: relId [ 
	^ self portableUtil httpJsonDelete: self relationshipUri // relId / 'properties' // propName
]

{ #category : 'deprecated-rest' }
N4RawClient >> deleteRelationshipAt: relId [ 
	^ self portableUtil httpJsonDelete: self relationshipUri // relId
]

{ #category : 'deprecated-rest' }
N4RawClient >> deleteRelationshipIndex: indexName [
	^ self portableUtil httpJsonDelete: self indexUri / 'relationship' // indexName
]

{ #category : 'deprecated-indexes' }
N4RawClient >> deleteRelationshipIndexes: indexName [
	^ self portableUtil httpJsonDelete: self indexUri / 'relationship' // indexName
]

{ #category : 'deprecated-rest' }
N4RawClient >> getAllRelationshipsAt: nodeId [
	^self getAllRelationshipsAt: nodeId types: nil
]

{ #category : 'deprecated-rest' }
N4RawClient >> getAllRelationshipsAt: nodeId types: typeCollection [
	^self getRelationshipsAt: nodeId direction: #all types: typeCollection
]

{ #category : 'discovering' }
N4RawClient >> getBasicInformation [
	^ self portableUtil getJsonFrom: self rootUri.
	
]

{ #category : 'deprecated-rest' }
N4RawClient >> getInRelationshipsAt: nodeId [
	^self getInRelationshipsAt: nodeId types: nil
]

{ #category : 'deprecated-rest' }
N4RawClient >> getInRelationshipsAt: nodeId types: typeCollection [
	^self getRelationshipsAt: nodeId direction: #in types: typeCollection
]

{ #category : 'deprecated-rest' }
N4RawClient >> getNodeAt: id [ 
	^ self portableUtil httpJsonGet: self nodeUri // id
		
]

{ #category : 'deprecated-rest' }
N4RawClient >> getNodeIndexes [
	^ self portableUtil getJsonFrom: self indexUri / 'node'
]

{ #category : 'deprecated-labels' }
N4RawClient >> getNodeLabelsAt: nodeId [ 
	^ self portableUtil getJsonOrEmptyFrom: self nodeUri // nodeId asString / 'labels'
]

{ #category : 'deprecated-rest' }
N4RawClient >> getNodeWithIndex: indexName key: key value: value [
	^ self portableUtil getJsonFrom: self indexUri / 'node' // indexName // key // value
]

{ #category : 'deprecated-rest' }
N4RawClient >> getOutRelationshipsAt: nodeId [
	^self getOutRelationshipsAt: nodeId types: nil
]

{ #category : 'deprecated-rest' }
N4RawClient >> getOutRelationshipsAt: nodeId types: typeCollection [
	^self getRelationshipsAt: nodeId direction: #out types: typeCollection
]

{ #category : 'deprecated-rest' }
N4RawClient >> getPropertiesNodeAt: nodeId [ 
	^ self portableUtil getJsonOrEmptyFrom: self nodeUri // nodeId asString / 'properties'
]

{ #category : 'deprecated-rest' }
N4RawClient >> getPropertiesRelationshipAt: relId [ 
	^ self portableUtil getJsonOrEmptyFrom: self relationshipUri // relId / 'properties'
]

{ #category : 'deprecated-rest' }
N4RawClient >> getProperty: propName nodeAt: nodeId [
	^ self portableUtil getJsonFrom: self nodeUri // nodeId / 'properties' // propName
]

{ #category : 'deprecated-rest' }
N4RawClient >> getProperty: propName relationshipAt: relId [
	^ self portableUtil getJsonFrom: self relationshipUri // relId / 'properties' // propName
]

{ #category : 'deprecated-rest' }
N4RawClient >> getRelationshipAt: id [ 
	^ self portableUtil getJsonFrom: self relationshipUri // id
		
]

{ #category : 'deprecated-rest' }
N4RawClient >> getRelationshipIndexes [
	^ self portableUtil getJsonFrom: self indexUri / 'relationship'
]

{ #category : 'deprecated-rest' }
N4RawClient >> getRelationshipTypes [
	^ self portableUtil getJsonFrom: self relationshipUri / 'types'
]

{ #category : 'deprecated-rest' }
N4RawClient >> getRelationshipWithIndex: indexName key: key value: value [
	^ self portableUtil getJsonFrom: self indexUri / 'relationship' // indexName // key // value
]

{ #category : 'deprecated-rest' }
N4RawClient >> getRelationshipsAt: nodeId direction: direction types: typeCollection [
	| uriStream |
	uriStream := WriteStream with: (self nodeUri // nodeId) asString.
	uriStream nextPutAll: '/relationships/' ; nextPutAll: (self portableUtil stringFrom: direction).
	(typeCollection isNil or: [typeCollection isEmpty]) ifFalse: [uriStream nextPut: $/.
		typeCollection do: [:each | uriStream nextPutAll: (self portableUtil urlEncodedStringFrom: each)] separatedBy: [uriStream nextPut: $&]
	].

	^ self portableUtil getJsonFrom: uriStream contents
]

{ #category : 'deprecated-rest' }
N4RawClient >> getRoot [
	^ self portableUtil getJsonFrom: self rootUri
]

{ #category : 'deprecated-accessing' }
N4RawClient >> indexUri [
	^self rootUri , 'index'
]

{ #category : 'deprecated-builder' }
N4RawClient >> newNodeIndexJson: uriOrNodeId key: key value: value [
	| uri jsonAssocs |
	jsonAssocs := OrderedCollection new: 3.
	uri := uriOrNodeId asString.
	(self portableUtil string: uri beginsWith: 'http:') ifFalse: [uri := (self rootUri, 'node/', uri)].
	jsonAssocs add: ('uri' -> uri).
	jsonAssocs add: ('key' -> key).
	jsonAssocs add: ('value' -> value).
	^jsonAssocs
]

{ #category : 'deprecated-builder' }
N4RawClient >> newQueryJson: queryString params: dictionary [
	| jsonAssocs |
	jsonAssocs := OrderedCollection new.
	jsonAssocs add: ('query' -> queryString).
	jsonAssocs add: ('params' -> dictionary).
	^jsonAssocs
]

{ #category : 'deprecated-builder' }
N4RawClient >> newRelationshipIndexJson: uriOrNodeId key: key value: value [
	| uri jsonAssocs |
	jsonAssocs := OrderedCollection new: 3.
	uri := uriOrNodeId asString.
	(self portableUtil string: uri beginsWith: 'http:') ifFalse: [uri := (self rootUri, 'relationship/', uri)].
	jsonAssocs add: ('uri' -> uri).
	jsonAssocs add: ('key' -> key).
	jsonAssocs add: ('value' -> value).
	^jsonAssocs
]

{ #category : 'deprecated-builder' }
N4RawClient >> newRelationshipJson: uriOrNodeId type: type properties: assocs [
	| uri jsonAssocs |
	jsonAssocs := OrderedCollection new: 3.
	uri := uriOrNodeId asString.
	(self portableUtil string: uri beginsWith: 'http:') ifFalse: [uri := (self rootUri, 'node/', uri)].
	jsonAssocs add: ('to' -> uri).
	jsonAssocs add: ('type' -> type).
	(assocs isNil or: [assocs isEmpty]) ifFalse: [
		jsonAssocs add: ('data' -> (self portableUtil dictionaryFromAssociations: assocs))
	].
	^jsonAssocs
]

{ #category : 'builder' }
N4RawClient >> newTransactionStatementJson: queryString params: dictionary [
	^self newTransactionStatementJson: queryString params: dictionary resultDataContents: nil includeStats: nil
]

{ #category : 'builder' }
N4RawClient >> newTransactionStatementJson: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean [
	| jsonDict |
	jsonDict := Dictionary new.
	jsonDict at: 'statement' put: queryString.
	dictionary isEmptyOrNil ifFalse: [jsonDict at: 'parameters' put: dictionary asDictionary].
	resultDataContents isEmptyOrNil ifFalse: [jsonDict at: 'resultDataContents' put: resultDataContents].
	aBoolean isNil ifFalse: [jsonDict at: 'includeStats' put: aBoolean].
	^jsonDict
]

{ #category : 'builder' }
N4RawClient >> newTransactionStatementsJson: statementDictionaries [
	| dict |
	dict := Dictionary new.
	dict at: 'statements' put: statementDictionaries.
	^dict
]

{ #category : 'deprecated-accessing' }
N4RawClient >> nodeUri [
	^ self rootUri , 'node'
]

{ #category : 'accessing' }
N4RawClient >> portableUtil [
	^portableUtil ifNil: [portableUtil := N4PortableUtil defaultClass new]
]

{ #category : 'accessing' }
N4RawClient >> portableUtil: aPortableUtil [
	portableUtil := aPortableUtil
]

{ #category : 'private' }
N4RawClient >> prepareTransactionUrl [
	self supportV4 ifFalse: [ ^ self rootUri, 'transaction', 'commit' ].
	
	^ self rootUri, 'db', self databaseName, 'tx', 'commit'
]

{ #category : 'actions-query' }
N4RawClient >> queryByCypher: queryString [
	^self queryByCypher: queryString params: nil
]

{ #category : 'actions-query' }
N4RawClient >> queryByCypher: queryString params: dictionary [
	^self queryByCypher: queryString params: dictionary resultDataContents: nil includeStats: nil
]

{ #category : 'actions-query' }
N4RawClient >> queryByCypher: queryString params: dictionary resultDataContents: resultDataContents [
	^self queryByCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: nil
]

{ #category : 'actions-query' }
N4RawClient >> queryByCypher: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean [
	"execute a query, and commit with just a single HTTP request"
	| statementDict json jsonString |
	statementDict := self newTransactionStatementJson: queryString params: dictionary resultDataContents: resultDataContents includeStats: aBoolean.
	json := self newTransactionStatementsJson: {statementDict}.
	jsonString := self portableUtil jsonStringFrom: json.
	^ self portableUtil httpJsonPost: self transactionUri content: jsonString
]

{ #category : 'actions-query' }
N4RawClient >> queryByCyphersUsing: queryBuildingBlock [
	| statements json jsonString |
	statements := queryBuildingBlock value: OrderedCollection new value: self.
	json := self newTransactionStatementsJson: statements asArray.
	jsonString := self portableUtil jsonStringFrom: json.
	^ self portableUtil httpJsonPost: self transactionUri content: jsonString
]

{ #category : 'deprecated-cypher' }
N4RawClient >> queryByLegacyCypher: queryString [
	^self queryByLegacyCypher: queryString params: Dictionary new
]

{ #category : 'deprecated-cypher' }
N4RawClient >> queryByLegacyCypher: queryString params: dictionary [
	| json jsonString |
	json := self newQueryJson: queryString params: dictionary.
	jsonString := self portableUtil jsonStringFrom: json.
	^ self portableUtil httpJsonPost: (self rootUri, 'cypher') content: jsonString
]

{ #category : 'deprecated-accessing' }
N4RawClient >> relationshipUri [
	^ self rootUri , 'relationship'
]

{ #category : 'deprecated-indexes' }
N4RawClient >> removeNodeIndexes: indexName on: nodeId [
	^ self portableUtil httpJsonDelete: (self indexUri / 'node' // indexName // nodeId) 
]

{ #category : 'deprecated-indexes' }
N4RawClient >> removeNodeIndexes: indexName on: nodeId key: key [
	^ self portableUtil httpJsonDelete: (self indexUri / 'node' // indexName // key // nodeId) 
]

{ #category : 'deprecated-indexes' }
N4RawClient >> removeNodeIndexes: indexName on: nodeId key: key value: value [
	^ self portableUtil httpJsonDelete: (self indexUri / 'node' // indexName // key // value // nodeId) 
]

{ #category : 'deprecated-indexes' }
N4RawClient >> removeRelationshipIndexes: indexName on: relId [
	^ self portableUtil httpJsonDelete: (self indexUri / 'relationship' // indexName // relId) 
]

{ #category : 'deprecated-indexes' }
N4RawClient >> removeRelationshipIndexes: indexName on: relId key: key [
	^ self portableUtil httpJsonDelete: (self indexUri / 'relationship' // indexName // key // relId) 
]

{ #category : 'deprecated-indexes' }
N4RawClient >> removeRelationshipIndexes: indexName on: relId key: key value: value [
	^ self portableUtil httpJsonDelete: (self indexUri / 'node' // indexName // key // value // relId) 
]

{ #category : 'accessing' }
N4RawClient >> rootUri [
	rootUri ifNil: [self rootUri: self settings rootUri].
	^rootUri 
]

{ #category : 'accessing' }
N4RawClient >> rootUri: anObject [
	anObject isNil ifTrue: [^rootUri := nil].
	rootUri := N4Url baseUrlString: anObject
]

{ #category : 'deprecated-labels' }
N4RawClient >> setLabels: labels nodeAt: nodeId [
	| jsonString urlString |
	urlString := self nodeUri // nodeId / 'labels'.
	jsonString := self portableUtil jsonStringFrom: labels.
	^ self portableUtil httpJsonPut: urlString content: jsonString 
]

{ #category : 'deprecated-rest' }
N4RawClient >> setProperties: properties nodeAt: nodeId [
	| jsonString urlString |
	urlString := self nodeUri // nodeId / 'properties'.
	jsonString := self portableUtil jsonStringFrom: properties.
	^ self portableUtil httpJsonPut: urlString content: jsonString 
]

{ #category : 'deprecated-rest' }
N4RawClient >> setProperties: properties relationshipAt: relId [
	| jsonString urlString |
	urlString := self relationshipUri // relId / 'properties'.
	jsonString := self portableUtil jsonStringFrom: properties.
	^ self portableUtil httpJsonPut: urlString content: jsonString 
]

{ #category : 'deprecated-rest' }
N4RawClient >> setProperty: propName to: value nodeAt: nodeId [ 
	| jsonString urlString |
	urlString := self nodeUri // nodeId / 'properties' // propName.
	jsonString := self portableUtil jsonStringFrom: value.
	^ self portableUtil httpJsonPut: urlString content: jsonString 
]

{ #category : 'deprecated-rest' }
N4RawClient >> setProperty: propName to: value relationshipAt: relId [ 
	| jsonString urlString |
	urlString := self relationshipUri // relId / 'properties' // propName.
	jsonString := self portableUtil jsonStringFrom: value.
	^ self portableUtil httpJsonPut: urlString content: jsonString 
]

{ #category : 'accessing' }
N4RawClient >> settings [
	settings ifNil: [ settings := N4Settings default ].
	^ settings
]

{ #category : 'accessing' }
N4RawClient >> settings: anObject [

	settings := anObject
]

{ #category : 'accessing' }
N4RawClient >> supportV4 [
	^self settings supportV4
	
]

{ #category : 'accessing' }
N4RawClient >> transactionUri [
	transactionUri ifNil: [ transactionUri := self prepareTransactionUrl ].
	^ transactionUri
]

{ #category : 'accessing' }
N4RawClient >> transactionUri: anObject [

	transactionUri := anObject
]

{ #category : 'deprecated-rest' }
N4RawClient >> traverseFrom: nodeId using: traversalDescription [
	| jsonString urlString |
	urlString := self nodeUri // nodeId / 'traverse' // traversalDescription returnType.
	jsonString := self portableUtil jsonStringFrom: traversalDescription asDictionary.
	^ self portableUtil httpJsonPost: urlString content: jsonString 
]
