Extension { #name : 'N4Node' }

{ #category : '*Neo4reSt-Traversal' }
N4Node >> all: type [
	^self traversal returnRelationship relAll: type
]

{ #category : '*Neo4reSt-Traversal' }
N4Node >> incoming: type [
	^self traversal returnRelationship relIn: type
]

{ #category : '*Neo4reSt-Traversal' }
N4Node >> outgoing: type [
	^self traversal returnRelationship relOut: type
]

{ #category : '*Neo4reSt-Traversal' }
N4Node >> traversal [
	^ N4Traversal from: self
]

{ #category : '*Neo4reSt-Traversal' }
N4Node >> traversal: settingBlock [
	| trav |
	trav := N4Traversal from: self.
	settingBlock value: trav.
	^trav
]
