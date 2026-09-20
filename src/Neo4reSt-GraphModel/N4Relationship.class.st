Class {
	#name : 'N4Relationship',
	#superclass : 'N4GraphObject',
	#category : 'Neo4reSt-GraphModel',
	#package : 'Neo4reSt-GraphModel'
}

{ #category : 'instance creation' }
N4Relationship class >> json: jsonObject [
	| inst |
	inst := self new.
	inst id: (self portableUtil pickIdFrom: (jsonObject at: 'self')).
	inst type: (jsonObject at: 'type').
	inst startNodeId: (self portableUtil pickIdFrom: (jsonObject at: 'start')). 
	inst endNodeId: (self portableUtil pickIdFrom: (jsonObject at: 'end')). 
	
	^inst
]

{ #category : 'instance creation' }
N4Relationship class >> json: jsonObject for: startNode [
	| inst |
	inst := self new.
	inst id: (self portableUtil pickIdFrom: (jsonObject at: 'self')).
	inst type: (jsonObject at: 'type').
	inst startNodeId: (self portableUtil pickIdFrom: (jsonObject at: 'start')). 
	inst endNodeId: (self portableUtil pickIdFrom: (jsonObject at: 'end')). 
	inst direction: ((inst startNodeId = startNode id) ifTrue: [#out] ifFalse: [#in]). 
	inst db: startNode db.
	^inst
]

{ #category : 'actions' }
N4Relationship >> delete [
	^self db deleteRelationshipAt: self id 
]

{ #category : 'accessing' }
N4Relationship >> direction [
	^self rawGraphObject direction
]

{ #category : 'printing' }
N4Relationship >> elementName [
	^'rel'
]

{ #category : 'accessing' }
N4Relationship >> endNode [
	^ self db nodeAt: self endNodeId
]

{ #category : 'accessing' }
N4Relationship >> endNodeId [
	^self rawGraphObject endNodeId
]

{ #category : 'accessing' }
N4Relationship >> headNode [
	^ self db nodeAt: self headNodeId
]

{ #category : 'accessing' }
N4Relationship >> headNodeId [
	self direction == #in ifTrue: [ self startNodeId ].
	^ self endNodeId
]

{ #category : 'properties' }
N4Relationship >> mergeProperties: propAssocs [
	| result |
	result := self db relationshipAt: self id mergeProperties: propAssocs.
	result ifTrue: [ self rawGraphObject mergeProperties: propAssocs ].
	^ result 
]

{ #category : 'printing' }
N4Relationship >> printOn: aStream [
	self printElementHeaderOn: aStream.
	aStream space.
	aStream nextPut: $(.
	aStream nextPutAll: self startNodeId asString.
	aStream nextPut: $).
	aStream space.
	self direction == #in ifTrue: [aStream nextPut: $<].
	aStream nextPut: $-.
	aStream nextPutAll: self type asString.
	aStream nextPut: $-.
	self direction == #out ifTrue: [aStream nextPut: $>].
	aStream space.
	aStream nextPut: $(.
	aStream nextPutAll: self endNodeId asString.
	aStream nextPut: $).
]

{ #category : 'properties' }
N4Relationship >> properties: propAssocs [
	| result |
	result := self db relationshipAt: self id properties: propAssocs.
	result ifTrue: [ self rawGraphObject properties: propAssocs ].
	^ result 
]

{ #category : 'properties' }
N4Relationship >> propertyAt: propName put: value [
	| result |
	result := self db relationshipAt: self id propertyAt: propName put: value.
	result ifTrue: [ self rawGraphObject propertyAt: propName put: value ].
	^ result 
]

{ #category : 'loading' }
N4Relationship >> reload [
	| newGraphObject |
	newGraphObject := self db relationshipAt: self id.
	self rawGraphObject: newGraphObject.
]

{ #category : 'properties' }
N4Relationship >> removePropertyAt: propName [
	| result |
	result := self db relationshipAt: self id removePropertyAt: propName.
	result ifTrue: [ self rawGraphObject removePropertyAt: propName ].
	^ result 
]

{ #category : 'accessing' }
N4Relationship >> startNode [
	^ self db nodeAt: self startNodeId
]

{ #category : 'accessing' }
N4Relationship >> startNodeId [
	^self rawGraphObject startNodeId
]

{ #category : 'accessing' }
N4Relationship >> tailNode [
	^ self db nodeAt: self tailNodeId
]

{ #category : 'accessing' }
N4Relationship >> tailNodeId [
	self direction == #in ifTrue: [ self endNodeId ].
	^ self startNodeId
]

{ #category : 'accessing' }
N4Relationship >> type [
	^self rawGraphObject type
]
