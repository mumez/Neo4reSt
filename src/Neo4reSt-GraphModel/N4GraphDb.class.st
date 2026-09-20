Class {
	#name : 'N4GraphDb',
	#superclass : 'N4Object',
	#category : 'Neo4reSt-GraphModel',
	#package : 'Neo4reSt-GraphModel'
}

{ #category : 'instance creation' }
N4GraphDb class >> settings: n4Settings [
	^self new settings: n4Settings 
]

{ #category : 'global operations' }
N4GraphDb >> allLabels [
	| n query labels label resp |
	n := 'n' asCypherIdentifier.
	query := CyQuery match: (n asNode).
	labels := 'labels' asCypherIdentifier.
	(query addWith: (n labels as: labels)) beDistinct.
	label := 'label' asCypherIdentifier.
	query addUnwind: (labels deepCopy as: label).
	(query addReturn: label) beDistinct.

	resp := self httpClient runCypher: query.
	^self firstFieldValuesOf: resp
]

{ #category : 'global operations' }
N4GraphDb >> allRelationshipTypes [
	| r query resp |
	r := 'r' asCypherIdentifier.
	query := CyQuery match: ('' asCypherIdentifier asNode - r asRelationship - '' asCypherIdentifier asNode).
	(query addReturn: r type) beDistinct.
	resp := self httpClient runCypher: query.
	^self firstFieldValuesOf: resp
]

{ #category : 'releasing' }
N4GraphDb >> close [
	self httpClient ifNotNil: [:cli | cli release]
	
]

{ #category : 'global operations' }
N4GraphDb >> countNodes [
	^ self countNodesLabeled: #()
]

{ #category : 'actions-nodes' }
N4GraphDb >> countNodesLabeled: labelOrLabels [
	| n node query resp |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n labels: labelOrLabels.
	query := CyQuery match: node.
	query addReturn: n count.
	resp := self httpClient runCypher: query.
	^ resp resultDo: [:result | result firstRowDo: [:row | row first]].
]

{ #category : 'global operations' }
N4GraphDb >> countRelationships [
	^ self countRelationshipsTyped: #()
	
]

{ #category : 'actions-relationships' }
N4GraphDb >> countRelationshipsTyped: typeOrTypes [
	| r types rel query resp |
	r := 'r' asCypherIdentifier.
	types := typeOrTypes isArray ifTrue: [ typeOrTypes ] ifFalse:[Array with: typeOrTypes].
	rel := r asRelationship types: types.
	query := CyQuery match: ('' asCypherIdentifier asNode - (rel) - '' asCypherIdentifier asNode).
	(query addReturn: (r id count) beDistinct).
	resp := self httpClient runCypher: query.
	^ resp resultDo: [:result | result firstRowDo: [:row | row first]].
]

{ #category : 'actions-relationships' }
N4GraphDb >> createInRelationshipTyped: type fromNodeId: startNodeId toNodeId: endNodeId properties: propertiesArray [
	| query |
	query := CyQuery
		matchPathWithNodeAt: startNodeId
		nodeAt: endNodeId
		createIn: [ :startNode :endNode :relIdentifier | 
			| rel |
			rel := relIdentifier rel: type props: propertiesArray.
			startNode <- rel - endNode ].
	^self cypherReturnInRelationship: query
]

{ #category : 'actions-nodes' }
N4GraphDb >> createNodeLabeled: labelOrLabels [
	^self createNodeLabeled: labelOrLabels properties: #()
]

{ #category : 'actions-nodes' }
N4GraphDb >> createNodeLabeled: labelOrLabels properties: props [
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n labels: labelOrLabels props: props. 
	query := CyQuery statements: {
		CyCreate of: node.
		CyReturn of: n.
	}.
	^self cypherReturnNode: query
]

{ #category : 'actions-relationships' }
N4GraphDb >> createOutRelationshipTyped: type fromNodeId: startNodeId toNodeId: endNodeId properties: propertiesArray [
	| query |
	query := CyQuery
		matchPathWithNodeAt: startNodeId
		nodeAt: endNodeId
		createIn: [ :startNode :endNode :relIdentifier | 
			| rel |
			rel := relIdentifier rel: type props: propertiesArray.
			startNode - rel -> endNode ].
	^self cypherReturnOutRelationship: query
]

{ #category : 'cypher-convenience' }
N4GraphDb >> cypherReturnInRelationship: query [
	^(self httpClient graphCypher: query) resultDo: [ :result | result firstGraphDo: [ :g | self relationshipClass on: g relationship beIn from: self] ]
]

{ #category : 'cypher-convenience' }
N4GraphDb >> cypherReturnNode: query [
	^(self httpClient graphCypher: query) resultDo: [ :r | r firstGraphDo: [ :g | self nodeClass on: g node from: self] ]
]

{ #category : 'cypher-convenience' }
N4GraphDb >> cypherReturnNodes: query [
	| nodes |
	nodes := OrderedCollection new.
	(self httpClient graphCypher: query) resultDo: [ :r |
		 r allGraphsDo: [:g | nodes add: (self nodeClass on: g node from: self)]
	].
	^ nodes
]

{ #category : 'cypher-convenience' }
N4GraphDb >> cypherReturnOutRelationship: query [
	^(self httpClient graphCypher: query) resultDo: [ :result | result firstGraphDo: [ :g | self relationshipClass on: g relationship beOut from: self] ]
]

{ #category : 'cypher-convenience' }
N4GraphDb >> cypherReturnRelationship: query [
	^(self httpClient graphCypher: query) resultDo: [ :result | result firstGraphDo: [ :g | self relationshipClass on: g relationship from: self] ]
]

{ #category : 'cypher-convenience' }
N4GraphDb >> cypherStatusOfContainUpdates: query arguments: arguments [
	^(self httpClient statsCypher: query params: arguments asDictionary)
		resultDo: [:r | r containsUpdates ]
]

{ #category : 'cypher-convenience' }
N4GraphDb >> cypherStatusOfNodesDeleted: query [
	^(self httpClient statsCypher: query) resultDo: [:r | r nodesDeleted > 0]
]

{ #category : 'cypher-convenience' }
N4GraphDb >> cypherStatusOfRelationshipDeleted: query [
	^(self httpClient statsCypher: query) resultDo: [:result | result relationshipDeleted > 0]
]

{ #category : 'global operations' }
N4GraphDb >> deleteAll [
	| n query |
	n := 'n' asCypherIdentifier.
	query := CyQuery match: n asNode.
	(query addDelete: n) withRelations: true.
	^self cypherStatusOfNodesDeleted: query
]

{ #category : 'global operations' }
N4GraphDb >> deleteAllNodes [
	^self deleteNodesLabeled: #() havingAll: #()
]

{ #category : 'global operations' }
N4GraphDb >> deleteAllRelationships [
	^self deleteRelationshipsTyped: #() havingAll: #()
]

{ #category : 'actions-nodes' }
N4GraphDb >> deleteNode: aNode [
	^self deleteNodeAt: aNode id
]

{ #category : 'actions-nodes' }
N4GraphDb >> deleteNodeAt: systemId [
	^self deleteNodeAt: systemId withRelations: false
]

{ #category : 'actions-nodes' }
N4GraphDb >> deleteNodeAt: systemId withRelations: withRelations [
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		delete: node in: [:del | del withRelations: withRelations].
	^self cypherStatusOfNodesDeleted: query
]

{ #category : 'actions-nodes' }
N4GraphDb >> deleteNodesLabeled: labelOrLabels [
	^self deleteNodesLabeled: labelOrLabels havingAll: #()
]

{ #category : 'actions-nodes' }
N4GraphDb >> deleteNodesLabeled: labelOrLabels havingAll: assocArray [
	^self deleteNodesLabeled: labelOrLabels where: [:node | node havingAll: assocArray]
]

{ #category : 'actions-nodes' }
N4GraphDb >> deleteNodesLabeled: labelOrLabels where: whereClauseBuilder [
	| node query |
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labelOrLabels)
		 where: (whereClauseBuilder value: node) delete: node.
	^self cypherStatusOfNodesDeleted: query
]

{ #category : 'actions-relationships' }
N4GraphDb >> deleteRelationshipAt: systemId [
	| s e r rel query |
	s := 's' asCypherIdentifier.
	e := 'e' asCypherIdentifier.
	r := 'r' asCypherIdentifier.
	rel := CyRelationship start: s end: e name: r. 
	query := CyQuery match: rel where: (r getId equals: systemId) delete: r.
	^self cypherStatusOfRelationshipDeleted: query
]

{ #category : 'actions-relationships' }
N4GraphDb >> deleteRelationshipsTyped: typeOrTypes [
	^ self deleteRelationshipsTyped: typeOrTypes havingAll: #()
]

{ #category : 'actions-relationships' }
N4GraphDb >> deleteRelationshipsTyped: typeOrTypes havingAll: propertiesArray [
	| r rel query |
	r := 'r' asCypherIdentifier.
	rel := r rel: typeOrTypes props: propertiesArray.
	query := CyQuery match: ('' asCypherIdentifier asNode - (rel) - '' asCypherIdentifier asNode).
	query addDelete: r.
	^self cypherStatusOfRelationshipDeleted: query
]

{ #category : 'printing' }
N4GraphDb >> elementName [
	^'db'
]

{ #category : 'actions-paths' }
N4GraphDb >> existsOneHopPathsTyped: typeOrTypes direction: direction from: startNodeId havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps whereIn: whereClauseBuilder [
	| pathBlock query |
	pathBlock := [ :startNode :rel :endNode | startNode - rel - endNode ].
	direction == #in ifTrue: [ pathBlock := [ :startNode :rel :endNode | startNode <- rel - endNode ]].
	direction == #out ifTrue: [ pathBlock := [ :startNode :rel :endNode | startNode - rel -> endNode ]].
	
	query := CyQuery
		matchPathWithRelationshipsOfTypes: typeOrTypes
		havingAll: relProps
		fromNodeAt: startNodeId
		endNodeIn: [ :e | e node: labels props: endNodeProps ]
		pathIn: pathBlock
		whereIn: whereClauseBuilder
		pathProcessIn: [:path | path count > 0 ]
		returnIn: [:r | r ].
	^(self httpClient runCypher: query) 
		resultDo: [ :result | result firstRowDo: [ :row | row first ] ]
]

{ #category : 'actions-paths' }
N4GraphDb >> existsOneHopPathsTyped: typeOrTypes direction: direction from: startNodeId whereIn: whereClauseBuilder [
	^ self existsOneHopPathsTyped: typeOrTypes direction: direction from: startNodeId havingAll: #() endNodeWithLabels: #() havingAll: #() whereIn: whereClauseBuilder
]

{ #category : 'private' }
N4GraphDb >> firstFieldValuesOf: aCypherResponse [
	^aCypherResponse result data inject: OrderedCollection new 
		into: [:sum :each | sum add: ((each at: 'row') first); yourself].
]

{ #category : 'private' }
N4GraphDb >> firstOrNilOf: aCollection [
	aCollection isEmpty ifTrue: [ ^ nil ].
	^ aCollection first
]

{ #category : 'actions-relationships' }
N4GraphDb >> mergeInRelationshipTyped: type fromNodeId: startNodeId toNodeId: endNodeId properties: propertiesArray [
	| query |
	query := CyQuery
		matchPathWithNodeAt: startNodeId
		nodeAt: endNodeId
		mergeIn: [ :startNode :endNode :relIdentifier | 
			| rel |
			rel := relIdentifier rel: type props: propertiesArray.
			startNode <- rel - endNode ].
	^self cypherReturnInRelationship: query
]

{ #category : 'actions-nodes' }
N4GraphDb >> mergeNodeLabeled: labelOrLabels [
	^self mergeNodeLabeled: labelOrLabels properties: #()
]

{ #category : 'actions-nodes' }
N4GraphDb >> mergeNodeLabeled: labelOrLabels havingAll: properties onCreateSet: createSetExpressionBuilder onMatchSet: matchSetExpressionBuilder [
	| n node query merge |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n labels: labelOrLabels props: properties.
	query := CyQuery match: node.
	merge := CyMerge of: node.
	createSetExpressionBuilder ifNotNil: [
		merge onCreateSet: (createSetExpressionBuilder value: n).	
	].
	matchSetExpressionBuilder ifNotNil: [ 
		merge onMatchSet: (matchSetExpressionBuilder value: n).
	].
	query := CyQuery statements: {
		merge.
		CyReturn of: n.
	}.
	^self cypherReturnNode: query
]

{ #category : 'actions-nodes' }
N4GraphDb >> mergeNodeLabeled: labelOrLabels properties: props [
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n labels: labelOrLabels props: props. 
	query := CyQuery statements: {
		CyMerge of: node.
		CyReturn of: n.
	}.
	^self cypherReturnNode: query
]

{ #category : 'actions-relationships' }
N4GraphDb >> mergeOutRelationshipTyped: type fromNodeId: startNodeId toNodeId: endNodeId properties: propertiesArray [
	| query |
	query := CyQuery
		matchPathWithNodeAt: startNodeId
		nodeAt: endNodeId
		mergeIn: [ :startNode :endNode :relIdentifier | 
			| rel |
			rel := relIdentifier rel: type props: propertiesArray.
			startNode - rel -> endNode ].
	^self cypherReturnOutRelationship: query
]

{ #category : 'actions-nodes' }
N4GraphDb >> nodeAt: systemId [
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		return: node.
	^self cypherReturnNode: query
]

{ #category : 'actions-nodes' }
N4GraphDb >> nodeAt: systemId mergeProperties: propsDict [
	| n node query args |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		set: (n addAll: 'values' asCypherParameter).
	args := { 'values' -> propsDict asDictionary } asDictionary.
	^self cypherStatusOfContainUpdates: query arguments: args
]

{ #category : 'actions-nodes' }
N4GraphDb >> nodeAt: systemId properties: propsDict [
	| n node query args |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		set: (n to: 'values' asCypherParameter).
	args := { 'values' -> propsDict asDictionary } asDictionary.
	^self cypherStatusOfContainUpdates: query arguments: args
]

{ #category : 'actions-nodes' }
N4GraphDb >> nodeAt: systemId propertyAt: key put: value [
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		set: {(n @ key) to: value}.
	^self cypherStatusOfContainUpdates: query arguments: #()
]

{ #category : 'actions-nodes' }
N4GraphDb >> nodeAt: systemId removePropertyAt: key [
	| n node query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n. 
	query := CyQuery match: node where: (n getId equals: systemId)
		remove: (n @ key).
	^self cypherStatusOfContainUpdates: query arguments: #()
]

{ #category : 'actions-nodes' }
N4GraphDb >> nodesLabeled: labelOrLabels [
	^self nodesLabeled: labelOrLabels havingAll: #()
]

{ #category : 'actions-nodes' }
N4GraphDb >> nodesLabeled: labelOrLabels having: key value: value [
	| propParam node query nodes |
	propParam := 'p' asCypherParameter.
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labelOrLabels)
		 where: ((node @ key) = propParam) return: node.
	nodes := OrderedCollection new.
	(self httpClient graphCypher: query params: {propParam -> value}) resultDo: [ :r |
		 r allGraphsDo: [:g | nodes add: (self nodeClass on: g node from: self)]
	].
	^ nodes
]

{ #category : 'actions-nodes' }
N4GraphDb >> nodesLabeled: labelOrLabels havingAll: assocArray [
	^self nodesLabeled: labelOrLabels where: [:node | node havingAll: assocArray]
]

{ #category : 'actions-nodes' }
N4GraphDb >> nodesLabeled: labelOrLabels where: whereClauseBuilder [
	| node query |
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labelOrLabels)
		 where: (whereClauseBuilder value: node) return: node.
	^ self cypherReturnNodes: query
]

{ #category : 'actions-nodes' }
N4GraphDb >> nodesLabeled: labelOrLabels where: whereClauseBuilder orderBy: orderByClauseBuilder skip: skip limit: limit [
	| node query |
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labelOrLabels)
		 where: (whereClauseBuilder value: node) return: node orderBy: (orderByClauseBuilder value: node) skip: skip limit: limit.
	^ self cypherReturnNodes: query
]

{ #category : 'actions-nodes' }
N4GraphDb >> nodesLabeled: labelOrLabels where: whereClauseBuilder skip: skip limit: limit [
	| node query |
	node := 'n' asCypherIdentifier.
	query := CyQuery match: (CyNode name: node labels: labelOrLabels)
		 where: (whereClauseBuilder value: node) return: node skip: skip limit: limit.
	^ self cypherReturnNodes: query
]

{ #category : 'actions-paths' }
N4GraphDb >> oneHopPathsTyped: typeOrTypes direction: direction from: startNodeId havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps whereIn: whereClauseBuilder [
	^ self oneHopPathsTyped: typeOrTypes direction: direction from: startNodeId havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps whereIn: whereClauseBuilder returnIn: nil returning: [:path | path]
]

{ #category : 'actions-paths' }
N4GraphDb >> oneHopPathsTyped: typeOrTypes direction: direction from: startNodeId havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps whereIn: whereClauseBuilder returnIn: returnBlock returning: returner [
	| pathBlock query |
	pathBlock := [ :startNode :rel :endNode | startNode - rel - endNode ].
	direction == #in ifTrue: [ pathBlock := [ :startNode :rel :endNode | startNode <- rel - endNode ]].
	direction == #out ifTrue: [ pathBlock := [ :startNode :rel :endNode | startNode - rel -> endNode ]].
	
	query := CyQuery
		matchPathWithRelationshipsOfTypes: typeOrTypes
		havingAll: relProps
		fromNodeAt: startNodeId
		endNodeIn: [ :e | e node: labels props: endNodeProps ]
		pathIn: pathBlock
		whereIn: whereClauseBuilder
		returnIn: returnBlock.
	^(self httpClient graphCypher: query) resultDo: [ :result | returner value: result ]
]

{ #category : 'global operations' }
N4GraphDb >> orphanedNodes [
	| n query |
	n := 'n' asCypherIdentifier.
	query := CyQuery match: n asNode where: (n asNode -- '' asCypherIdentifier asNode) exists not return: n.
	^ self cypherReturnNodes: query
]

{ #category : 'printing' }
N4GraphDb >> printElementHeaderOn: aStream [
	aStream nextPutAll: self elementName.
	aStream nextPut: $[.
	self httpClient rootUri printOn: aStream.
	aStream nextPut: $]
	
]

{ #category : 'actions-cypher-basic' }
N4GraphDb >> queryByCypher: queryString [
	^self httpClient queryByCypher: queryString
]

{ #category : 'actions-cypher-basic' }
N4GraphDb >> queryByCypher: queryString arguments: argsDictionary [
	^self httpClient queryByCypher: queryString params: argsDictionary asDictionary
]

{ #category : 'actions-cypher-basic' }
N4GraphDb >> queryByCyphers: queryStrings [
	^self httpClient queryByCyphers: queryStrings
]

{ #category : 'actions-cypher-basic' }
N4GraphDb >> queryByCyphersWithArguments: queryStringsWithArguments [
	^self httpClient queryByCyphersWithParams: queryStringsWithArguments
]

{ #category : 'actions-relationships' }
N4GraphDb >> relationshipAt: systemId [
	| s e r rel query |
	s := 's' asCypherIdentifier.
	e := 'e' asCypherIdentifier.
	r := 'r' asCypherIdentifier.
	rel := CyRelationship start: s end: e name: r. 
	query := CyQuery match: rel where: (r getId equals: systemId) return: r.
	^self cypherReturnRelationship: query
]

{ #category : 'actions-relationships' }
N4GraphDb >> relationshipAt: systemId mergeProperties: propsDict [
	| s e r rel query args |
	s := 's' asCypherIdentifier.
	e := 'e' asCypherIdentifier.
	r := 'r' asCypherIdentifier.
	rel := CyRelationship start: s end: e name: r. 
	query := CyQuery match: rel where: (r getId equals: systemId)
		set: (r addAll: 'values' asCypherParameter).	
	args := { 'values' -> propsDict asDictionary } asDictionary.
	^self cypherStatusOfContainUpdates: query arguments: args
]

{ #category : 'actions-relationships' }
N4GraphDb >> relationshipAt: systemId properties: propsDict [
	| s e r rel query args |
	s := 's' asCypherIdentifier.
	e := 'e' asCypherIdentifier.
	r := 'r' asCypherIdentifier.
	rel := CyRelationship start: s end: e name: r. 
	query := CyQuery match: rel where: (r getId equals: systemId)
		set: (r to: 'values' asCypherParameter).
	args := { 'values' -> propsDict asDictionary } asDictionary.
	^self cypherStatusOfContainUpdates: query arguments: args
]

{ #category : 'actions-relationships' }
N4GraphDb >> relationshipAt: systemId propertyAt: key put: value [
	| s e r rel query |
	s := 's' asCypherIdentifier.
	e := 'e' asCypherIdentifier.
	r := 'r' asCypherIdentifier.
	rel := CyRelationship start: s end: e name: r. 
	query := CyQuery match: rel where: (r getId equals: systemId)
		set: {(r @ key) to: value}.
	^self cypherStatusOfContainUpdates: query arguments: #()
]

{ #category : 'actions-relationships' }
N4GraphDb >> relationshipAt: systemId removePropertyAt: key [
	| s e r rel query |
	s := 's' asCypherIdentifier.
	e := 'e' asCypherIdentifier.
	r := 'r' asCypherIdentifier.
	rel := CyRelationship start: s end: e name: r. 
	query := CyQuery match: rel where: (r getId equals: systemId)
		remove: (r @ key).
	^self cypherStatusOfContainUpdates: query arguments: #()
]

{ #category : 'actions-relationships' }
N4GraphDb >> relationshipsTyped: typeOrTyped [
	^self relationshipsTyped: typeOrTyped havingAll: #()
]

{ #category : 'actions-relationships' }
N4GraphDb >> relationshipsTyped: typeOrTypes having: key value: value [
	| propParam r rel query relationships |
	propParam := 'p' asCypherParameter.
	r := 'r' asCypherIdentifier.
	rel := r rel: typeOrTypes props: #().
	query := CyQuery match: ('' asCypherIdentifier asNode - (rel) -> '' asCypherIdentifier asNode)
		 where: ((r @ key) = propParam) return: r.
	relationships := OrderedCollection new.
	(self httpClient graphCypher: query params: {propParam -> value}) resultDo: [ :result |
		 result allGraphsDo: [:g | relationships add: (self relationshipClass on: g relationship beOut from: self)]
	].
	^ relationships
]

{ #category : 'actions-relationships' }
N4GraphDb >> relationshipsTyped: typeOrTyped havingAll: assocArray [
	^self relationshipsTyped: typeOrTyped where: [:relationship | relationship havingAll: assocArray]
]

{ #category : 'actions-relationships' }
N4GraphDb >> relationshipsTyped: typeOrTypes where: whereClauseBuilder [
	^self relationshipsTyped: typeOrTypes where: whereClauseBuilder orderBy: nil skip: nil limit: nil
]

{ #category : 'actions-relationships' }
N4GraphDb >> relationshipsTyped: typeOrTypes where: whereClauseBuilder orderBy: orderByClauseBuilder skip: skip limit: limit [
	| r rel query relationships |
	r := 'r' asCypherIdentifier.
	rel := r rel: typeOrTypes props: #().
	query := CyQuery match: ('' asCypherIdentifier asNode - (rel) -> '' asCypherIdentifier asNode)
		 where: (whereClauseBuilder value: r) return: r orderBy: (orderByClauseBuilder value: r) skip: skip limit: limit.
	relationships := OrderedCollection new.
	(self httpClient graphCypher: query) resultDo: [ :result |
		 result allGraphsDo: [:g | relationships add: (self relationshipClass on: g relationship beOut from: self)]
	].
	^ relationships
]

{ #category : 'releasing' }
N4GraphDb >> release [
	self close
]

{ #category : 'actions-cypher' }
N4GraphDb >> runCypher: cypherQueryOrString [
	^ self runCypher: cypherQueryOrString arguments: #() 
]

{ #category : 'actions-cypher' }
N4GraphDb >> runCypher: cypherQueryOrString arguments: argsDict [
	| queryString |
	queryString := cypherQueryOrString isString
		               ifTrue: [ cypherQueryOrString ]
		               ifFalse: [ cypherQueryOrString cypherString ].
	^ self queryByCypher: queryString arguments: argsDict 
]

{ #category : 'actions-cypher' }
N4GraphDb >> runCyphers: cypherQueryOrStrings [
	| queryStrings |
	queryStrings := cypherQueryOrStrings collect: [:each | each isString
		               ifTrue: [ each ]
		               ifFalse: [ each cypherString ]].
	^ self queryByCyphers: queryStrings
]

{ #category : 'actions-cypher' }
N4GraphDb >> runCyphersBy: aStatementsAppenderBlock [
	| appender |
	appender := N4CypherStatementAppender new.
	aStatementsAppenderBlock value: appender.
	^self queryByCyphersWithArguments: appender cyphersWithArguments
]

{ #category : 'logging' }
N4GraphDb >> startLoggingToTranscript [
	self httpClient startLoggingToTranscript
]

{ #category : 'logging' }
N4GraphDb >> stopLogging [
	self httpClient stopLogging
]
