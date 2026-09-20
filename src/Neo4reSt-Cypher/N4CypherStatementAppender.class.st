Class {
	#name : 'N4CypherStatementAppender',
	#superclass : 'Object',
	#instVars : [
		'statements'
	],
	#category : 'Neo4reSt-Cypher',
	#package : 'Neo4reSt-Cypher'
}

{ #category : 'actions' }
N4CypherStatementAppender >> cypher: cypherString [
	self statements add: cypherString
]

{ #category : 'actions' }
N4CypherStatementAppender >> cypher: cypherString arguments: arguments [
	self statements add: {cypherString. arguments}
]

{ #category : 'private' }
N4CypherStatementAppender >> cypherStringFrom: stringOrCypherObject [
	^ stringOrCypherObject isString ifTrue: [ stringOrCypherObject ] ifFalse: [ stringOrCypherObject cypherString ]
]

{ #category : 'accessing' }
N4CypherStatementAppender >> cyphersWithArguments [
	^ self statements collect: [ :statement | 
		  statement isArray
			  ifTrue: [ 
				  { (self cypherStringFrom: statement first). statement second } ]
			  ifFalse: [ self cypherStringFrom: statement ] ]
]

{ #category : 'initialize-release' }
N4CypherStatementAppender >> initialize [
	statements := OrderedCollection new
]

{ #category : 'accessing' }
N4CypherStatementAppender >> statements [
	^ statements
]
