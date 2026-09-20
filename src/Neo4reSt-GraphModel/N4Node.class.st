Class {
	#name : 'N4Node',
	#superclass : 'N4GraphObject',
	#category : 'Neo4reSt-GraphModel',
	#package : 'Neo4reSt-GraphModel'
}

{ #category : 'instance creation' }
N4Node class >> json: jsonObject [
	| inst |
	inst := self new.
	inst id: (self portableUtil pickIdFrom: (jsonObject at: 'self')).
	inst properties: (jsonObject at: 'data').
	^inst
]

{ #category : 'actions-labels' }
N4Node >> addLabel: label [
	^ self addLabels: {label}
]

{ #category : 'actions-labels' }
N4Node >> addLabels: labels [
	| n node paramId query result |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n.
	paramId := 'id' asCypherParameter. 
	query := CyQuery match: node where: (n getId equals: paramId) set: (n labels: labels).
	result := self db cypherStatusOfContainUpdates: query arguments: {paramId -> self id}.
	result ifTrue: [ self rawGraphObject addLabels: labels ].
	^ result
]

{ #category : 'accessing' }
N4Node >> allLabels [
	| n node paramId query |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n.
	paramId := 'id' asCypherParameter. 
	query := CyQuery match: node where: (n getId equals: paramId)
		return: (CyFuncInvocation labels: node).
	^ (self db queryByCypher: query cypherString arguments: { paramId -> self id })	
		resultDo: [ :result | result firstRowDo: [ :row | row first ] ]
]

{ #category : 'deleting' }
N4Node >> delete [
	^self db deleteNodeAt: self id
]

{ #category : 'deleting' }
N4Node >> deleteWithRelations [
	^self db deleteNodeAt: self id withRelations: true
]

{ #category : 'printing' }
N4Node >> elementName [
	^'node'
]

{ #category : 'accessing-relationships-existence' }
N4Node >> existsInRelationshipTyped: typeOrTypes [
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #in
		from: self id
		whereIn: [:start :rel :end |]
]

{ #category : 'accessing-relationships-existence' }
N4Node >> existsInRelationshipTyped: typeOrTypes endNodeHaving: key value: value [
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #in
		from: self id
		whereIn: [:start :rel :end | (end prop: key) = value]
]

{ #category : 'accessing-relationships-existence' }
N4Node >> existsInRelationshipTyped: typeOrTypes having: key value: value [
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #in
		from: self id
		whereIn: [:start :rel :end | (rel prop: key) = value]
]

{ #category : 'accessing-relationships-existence' }
N4Node >> existsOutRelationshipTyped: typeOrTypes [
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #out
		from: self id
		whereIn: [:start :rel :end |]
]

{ #category : 'accessing-relationships-existence' }
N4Node >> existsOutRelationshipTyped: typeOrTypes endNodeHaving: key value: value [
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #out
		from: self id
		whereIn: [:start :rel :end | (end prop: key) = value]
]

{ #category : 'accessing-relationships-existence' }
N4Node >> existsOutRelationshipTyped: typeOrTypes having: key value: value [
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #out
		from: self id
		whereIn: [:start :rel :end | (rel prop: key) = value]
]

{ #category : 'accessing-relationships-existence' }
N4Node >> existsRelationshipTyped: typeOrTypes [
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #none
		from: self id
		whereIn: [:start :rel :end |]
]

{ #category : 'accessing-relationships-existence' }
N4Node >> existsRelationshipTyped: typeOrTypes endNodeHaving: key value: value [
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #none
		from: self id
		whereIn: [:start :rel :end | (end prop: key) = value]
]

{ #category : 'accessing-relationships-existence' }
N4Node >> existsRelationshipTyped: typeOrTypes having: key value: value [
	^ self db
		existsOneHopPathsTyped: typeOrTypes
		direction: #none
		from: self id
		whereIn: [:start :rel :end | (rel prop: key) = value]
]

{ #category : 'accessing-paths' }
N4Node >> inOneHopPathsTyped: typeOrTypes havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps [
	^ self db
		oneHopPathsTyped: typeOrTypes
		direction: #in
		from: self id
		havingAll: relProps
		endNodeWithLabels: labels
		havingAll: endNodeProps
		whereIn: [:start :rel :end |]
]

{ #category : 'accessing-paths' }
N4Node >> inOneHopPathsTyped: typeOrTypes where: where [
	^ self db
		oneHopPathsTyped: typeOrTypes
		direction: #in
		from: self id
		havingAll: {}
		endNodeWithLabels: {}
		havingAll: {}
		whereIn: where
]

{ #category : 'accessing-relationships' }
N4Node >> inRelationships [
	^ self inRelationshipsTyped: {}
]

{ #category : 'cypher-convenience' }
N4Node >> inRelationshipsFromGraphResult: aCypherGraphResult [
	^ aCypherGraphResult relationships collect:[ :rel | self relationshipClass on: rel beIn from: self db]
]

{ #category : 'accessing-relationships' }
N4Node >> inRelationshipsTyped: typeOrTypes [
	^ self inRelationshipsTyped: typeOrTypes havingAll: {} endNodeWithLabels: {} havingAll: {}
]

{ #category : 'accessing-relationships' }
N4Node >> inRelationshipsTyped: typeOrTypes endNodeHaving: key value: value [
	^ self inRelationshipsTyped: typeOrTypes havingAll: {} endNodeWithLabels: {} havingAll: {key->value}
]

{ #category : 'accessing-relationships' }
N4Node >> inRelationshipsTyped: typeOrTypes having: key value: value [
	^ self inRelationshipsTyped: typeOrTypes havingAll: {key->value} endNodeWithLabels: {} havingAll: {}
]

{ #category : 'accessing-relationships' }
N4Node >> inRelationshipsTyped: typeOrTypes havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps [
	^ self inRelationshipsFromGraphResult: (self
		inOneHopPathsTyped: typeOrTypes
		havingAll: relProps
		endNodeWithLabels: labels
		havingAll: endNodeProps)
]

{ #category : 'accessing-relationships' }
N4Node >> inRelationshipsTyped: typeOrTypes where: where [
	^ self inRelationshipsFromGraphResult: (self inOneHopPathsTyped: typeOrTypes where: where)
]

{ #category : 'accessing' }
N4Node >> label [
	| labels |
	labels := self labels.
	labels isEmpty ifTrue: [ ^nil ].
	^labels at: 1
]

{ #category : 'accessing' }
N4Node >> labels [
	^ self rawGraphObject labels
]

{ #category : 'properties' }
N4Node >> mergeProperties: propAssocs [
	| result |
	result := self db nodeAt: self id mergeProperties: propAssocs.
	result ifTrue: [ self rawGraphObject mergeProperties: propAssocs ].
	^ result 
]

{ #category : 'accessing-paths' }
N4Node >> oneHopPathsTyped: typeOrTypes havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps [
	^ self db
		oneHopPathsTyped: typeOrTypes
		direction: nil
		from: self id
		havingAll: relProps
		endNodeWithLabels: labels
		havingAll: endNodeProps
		whereIn: [:start :rel :end |]
]

{ #category : 'accessing-paths' }
N4Node >> oneHopPathsTyped: typeOrTypes where: where [
	^ self db
		oneHopPathsTyped: typeOrTypes
		direction: nil
		from: self id
		havingAll: {}
		endNodeWithLabels: {}
		havingAll: {}
		whereIn: where
]

{ #category : 'accessing-paths' }
N4Node >> outOneHopPathsTyped: typeOrTypes havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps [
	^ self db
		oneHopPathsTyped: typeOrTypes
		direction: #out
		from: self id
		havingAll: relProps
		endNodeWithLabels: labels
		havingAll: endNodeProps
		whereIn: [:start :rel :end |]
]

{ #category : 'accessing-paths' }
N4Node >> outOneHopPathsTyped: typeOrTypes where: where [
	^ self db
		oneHopPathsTyped: typeOrTypes
		direction: #out
		from: self id
		havingAll: {}
		endNodeWithLabels: {}
		havingAll: {}
		whereIn: where
]

{ #category : 'accessing-relationships' }
N4Node >> outRelationships [
	^ self outRelationshipsTyped: {}
]

{ #category : 'cypher-convenience' }
N4Node >> outRelationshipsFromGraphResult: aCypherGraphResult [
	^ aCypherGraphResult relationships collect:[ :rel | self relationshipClass on: rel beOut from: self db]
]

{ #category : 'accessing-relationships' }
N4Node >> outRelationshipsTyped: typeOrTypes [
	^ self outRelationshipsTyped: typeOrTypes havingAll: {} endNodeWithLabels: {} havingAll: {}
]

{ #category : 'accessing-relationships' }
N4Node >> outRelationshipsTyped: typeOrTypes endNodeHaving: key value: value [
	^ self outRelationshipsTyped: typeOrTypes havingAll: {} endNodeWithLabels: {} havingAll: {key->value}
]

{ #category : 'accessing-relationships' }
N4Node >> outRelationshipsTyped: typeOrTypes having: key value: value [
	^ self outRelationshipsTyped: typeOrTypes havingAll: {key->value} endNodeWithLabels: {} havingAll: {}
]

{ #category : 'accessing-relationships' }
N4Node >> outRelationshipsTyped: typeOrTypes havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps [
	^  self outRelationshipsFromGraphResult: (self
		outOneHopPathsTyped: typeOrTypes
		havingAll: relProps
		endNodeWithLabels: labels
		havingAll: endNodeProps)
]

{ #category : 'accessing-relationships' }
N4Node >> outRelationshipsTyped: typeOrTypes where: where [
	^  self outRelationshipsFromGraphResult: (self outOneHopPathsTyped: typeOrTypes where: where)
]

{ #category : 'properties' }
N4Node >> properties: propAssocs [
	| result |
	result := self db nodeAt: self id properties: propAssocs.
	result ifTrue: [ self rawGraphObject properties: propAssocs ].
	^ result 
]

{ #category : 'properties' }
N4Node >> propertyAt: propName put: value [
	| result |
	result := self db nodeAt: self id propertyAt: propName put: value.
	result ifTrue: [ self rawGraphObject propertyAt: propName put: value ].
	^ result 
]

{ #category : 'relationships' }
N4Node >> relateOneTo: otherNode typed: typeName [
	^self relateOneTo: otherNode typed: typeName properties: #()
]

{ #category : 'relationships' }
N4Node >> relateOneTo: otherNode typed: type properties: propertiesArray [
	| newRelationship |
	newRelationship := self db mergeOutRelationshipTyped: type fromNodeId: self id toNodeId: otherNode id properties: propertiesArray.
	^ newRelationship
]

{ #category : 'relationships' }
N4Node >> relateTo: otherNode typed: typeName [
	^self relateTo: otherNode typed: typeName properties: #()
]

{ #category : 'relationships' }
N4Node >> relateTo: otherNode typed: type properties: propertiesArray [
	| newRelationship |
	newRelationship := self db createOutRelationshipTyped: type fromNodeId: self id toNodeId: otherNode id properties: propertiesArray.
	^ newRelationship
]

{ #category : 'accessing-relationships' }
N4Node >> relationships [
	^ self relationshipsTyped: {}
]

{ #category : 'cypher-convenience' }
N4Node >> relationshipsFromGraphResult: aCypherGraphResult [
	^ aCypherGraphResult relationships collect:[ :rel | self relationshipClass on: rel from: self db]
]

{ #category : 'accessing-relationships' }
N4Node >> relationshipsTyped: typeOrTypes [
	^ self relationshipsTyped: typeOrTypes havingAll: {} endNodeWithLabels: {} havingAll: {}
]

{ #category : 'accessing-relationships' }
N4Node >> relationshipsTyped: typeOrTypes endNodeHaving: key value: value [
	^ self relationshipsTyped: typeOrTypes havingAll: {} endNodeWithLabels: {} havingAll: {key->value}
]

{ #category : 'accessing-relationships' }
N4Node >> relationshipsTyped: typeOrTypes having: key value: value [
	^ self relationshipsTyped: typeOrTypes havingAll: {key->value} endNodeWithLabels: {} havingAll: {}
]

{ #category : 'accessing-relationships' }
N4Node >> relationshipsTyped: typeOrTypes havingAll: relProps endNodeWithLabels: labels havingAll: endNodeProps [
	^  self relationshipsFromGraphResult: (self
		oneHopPathsTyped: typeOrTypes
		havingAll: relProps
		endNodeWithLabels: labels
		havingAll: endNodeProps)
]

{ #category : 'accessing-relationships' }
N4Node >> relationshipsTyped: typeOrTypes where: where [
	^ self relationshipsFromGraphResult: (self oneHopPathsTyped: typeOrTypes where: where)
]

{ #category : 'loading' }
N4Node >> reload [
	| newGraphObject |
	newGraphObject := self db nodeAt: self id.
	self rawGraphObject: newGraphObject.
]

{ #category : 'actions-labels' }
N4Node >> removeLabel: label [
	^ self removeLabels: {label}
]

{ #category : 'actions-labels' }
N4Node >> removeLabels: labels [
	| n node paramId query result |
	n := 'n' asCypherIdentifier.
	node := CyNode name: n.
	paramId := 'id' asCypherParameter. 
	query := CyQuery match: node where: (n getId equals: paramId) remove: (n labels: labels).
	result := self db cypherStatusOfContainUpdates: query arguments: {paramId -> self id}.
	result ifTrue: [ self rawGraphObject removeLabels: labels ].
	^ result
]

{ #category : 'properties' }
N4Node >> removePropertyAt: propName [
	| result |
	result := self db nodeAt: self id removePropertyAt: propName.
	result ifTrue: [ self rawGraphObject removePropertyAt: propName ].
	^ result 
]

{ #category : 'accessing' }
N4Node >> types [
	^ (self relationships collect: [:each | each type]) asSet
]
