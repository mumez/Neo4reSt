Class {
	#name : 'N4GraphDbTest',
	#superclass : 'TestCase',
	#classInstVars : [
		'defaultSettings'
	],
	#category : 'Neo4reSt-Tests',
	#package : 'Neo4reSt-Tests'
}

{ #category : 'class initialization' }
N4GraphDbTest class >> defaultSettings [
	^defaultSettings ifNil: [ defaultSettings := N4Settings new]
]

{ #category : 'class initialization' }
N4GraphDbTest class >> initSettingsExample [
	<script>
	"Assuming that password is set to 'neoneo'"
	self defaultSettings password: 'neoneo'.
	
	"You can use a database name other than 'neo4j'"
	"self defaultSettings databaseName: 'neo4rest'."
]

{ #category : 'class initialization' }
N4GraphDbTest class >> initialize [
	defaultSettings := nil
]

{ #category : 'private' }
N4GraphDbTest >> dbDo: aBlock [
	| db |
	db := N4GraphDb settings: self settings.
	[aBlock value: db ]
		ifCurtailed: [ db release ]
]

{ #category : 'accessing' }
N4GraphDbTest >> settings [
	^self class defaultSettings
]

{ #category : 'testing' }
N4GraphDbTest >> testAddRemoveLabelsOfNode [
	self dbDo: [ :db | | nodeCreated nodeRetrieved deletedResult |
		nodeCreated := db createNodeLabeled: 'label1'.	
		nodeRetrieved := db nodeAt: nodeCreated id.
		self assert: nodeRetrieved labels equals: #('label1').
		nodeRetrieved addLabel: 'label2'.
		self assert: nodeRetrieved labels sorted equals: #('label1' 'label2').
		nodeRetrieved addLabels: #('label3' 'label4').
		self assert: nodeRetrieved labels sorted equals: #('label1' 'label2' 'label3' 'label4').
		nodeRetrieved removeLabels: #('label1' 'label2').
		self assert: nodeRetrieved labels sorted equals: #('label3' 'label4').
		nodeRetrieved removeLabel: 'label3'.
		self assert: nodeRetrieved labels sorted equals: #('label4').
		deletedResult := nodeRetrieved delete.
		self assert: deletedResult equals: true.
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testAllLabels [
	self dbDo: [ :db | | node1 node2 node3 node4 |
		node1 := db createNodeLabeled: 'label1'.	
		node2 := db createNodeLabeled: 'label2'.	
		node3 := db createNodeLabeled: 'label3'.
		node4 := db createNodeLabeled: 'label2'.
		self assert: db allLabels asArray sorted equals: #('label1' 'label2' 'label3').
		node1 delete.
		node2 delete.
		self assert: db allLabels asArray sorted equals: #('label2' 'label3').
		node3 delete.
		node4 delete.
		self assert: db allLabels asArray sorted equals: #().
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testAllRelationshipTypes [
	self dbDo: [ :db | | node1 node2 node3 node4 rel1 rel2 rel3 rel4 |
		node1 := db createNodeLabeled: 'label1'.	
		node2 := db createNodeLabeled: 'label1'.
		node3 := db createNodeLabeled: 'label1'.
		node4 := db createNodeLabeled: 'label1'.	
		rel1 := node1 relateOneTo: node2 typed: 'REL1'.
		rel2 := node2 relateOneTo: node1 typed: 'REL2'.
		rel3 := node3 relateOneTo: node4 typed: 'REL3'.
		rel4 := node4 relateOneTo: node3 typed: 'REL2'.
		self assert: db allRelationshipTypes asArray sorted equals: #('REL1' 'REL2' 'REL3').
		rel1 delete.
		rel2 delete.
		self assert: db allRelationshipTypes asArray sorted equals: #('REL2' 'REL3').
		rel3 delete.
		rel4 delete.
		self assert: db allRelationshipTypes asArray sorted equals: #().
		db deleteNodesLabeled: 'label1'
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testCreateAccessRelationshipsFromNodes [
	self dbDo: [ :db | | nodeCreated1 nodeCreated2 outRelCreated1 outRelCreated2 outRelCreated3 outRelCreated4 outRelCreated5 outRelsRetrieved1 outRelRetrieved1 outRelsRetrieved2 outRelRetrieved2 outRelsRetrieved3 |
		nodeCreated1 := db createNodeLabeled: 'test'.
		nodeCreated2 := db createNodeLabeled: 'test'.
		outRelCreated1 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL1 properties: {#a->1}.
		outRelCreated2 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL2 properties: {}.
		outRelCreated3 := nodeCreated1 relateTo: nodeCreated2 typed: #REL3 properties: {}.
		outRelCreated4 := nodeCreated1 relateTo: nodeCreated2 typed: #REL3 properties: {}.
		outRelCreated5 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL1 properties: {#a->1}.
		
		outRelsRetrieved1 := nodeCreated1 outRelationshipsTyped: #REL1.
		self assert: (outRelsRetrieved1 size) equals: 1.
		outRelRetrieved1 := outRelsRetrieved1 first.
		self assert: outRelRetrieved1 properties asDictionary associations equals: {#a->1} asDictionary associations.
		
		outRelsRetrieved2 := nodeCreated1 outRelationshipsTyped: #REL2.
		self assert: (outRelsRetrieved2 size) equals: 1.
		outRelRetrieved2 := outRelsRetrieved2 first.
		
		outRelsRetrieved3 := nodeCreated1 outRelationshipsTyped: #REL3.
		self assert: (outRelsRetrieved3 size) equals: 2.
		
		self assert: (nodeCreated1 outRelationships size) equals: 4.
		
		self assert: outRelRetrieved1 delete equals: true.
		self assert: outRelRetrieved2 delete equals: true.
		outRelsRetrieved3 do: [ :each | 
			self assert: each delete equals: true.
		].
		self assert: nodeCreated1 delete equals: true.
		self assert: nodeCreated2 delete equals: true.
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testCreateDeleteNodes [
	self dbDo: [ :db | | nodeCreated nodeRetrieved deletedResult deletedNodeRetrieved |
		nodeCreated := db createNodeLabeled: 'test' properties: {#a -> 1}.	
		nodeRetrieved := db nodeAt: nodeCreated id.
		self assert: nodeRetrieved id equals: nodeCreated id.
		self assert: (nodeRetrieved propertyAt: #a) equals: 1.
		deletedResult := nodeRetrieved delete.
		self assert: deletedResult equals: true.
		deletedNodeRetrieved := db nodeAt: nodeCreated id.
		self assert: deletedNodeRetrieved equals: nil.
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testCreateDeleteRelationships [
	self dbDo: [ :db | | nodeCreated1 nodeCreated2 inRelCreated outRelCreated inRelRetrieved outRelRetrieved deletedInRel deletedOutRel |
		nodeCreated1 := db createNodeLabeled: 'test'.
		nodeCreated2 := db createNodeLabeled: 'test'.
		inRelCreated := db createInRelationshipTyped: 'REL1' fromNodeId: nodeCreated1 id toNodeId: nodeCreated2 id properties: {#a->1}.
		outRelCreated := db createOutRelationshipTyped: 'REL1' fromNodeId: nodeCreated1 id toNodeId: nodeCreated2 id properties: {#a->2}.
		inRelRetrieved := db relationshipAt: inRelCreated id.
		outRelRetrieved := db relationshipAt: outRelCreated id.
		self assert: inRelRetrieved id equals: inRelCreated id.
		self assert: outRelRetrieved id equals: outRelCreated id.
		self assert: inRelCreated direction equals: #in.
		self assert: outRelCreated direction equals: #out.
		self assert: (inRelRetrieved propertyAt: #a) equals: 1.
		self assert: (outRelRetrieved propertyAt: #a) equals: 2.
		deletedInRel := inRelRetrieved delete.
		deletedOutRel := outRelRetrieved delete.
		self assert: deletedInRel equals: true.
		self assert: deletedOutRel equals: true.
		self assert: (db relationshipAt: inRelCreated id) equals: nil.
		self assert: (db relationshipAt: outRelCreated id) equals: nil.
		self assert: (db deleteNodeAt: nodeCreated1 id) equals: true.
		self assert: (db deleteNodeAt: nodeCreated2 id) equals: true.
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testDeleteNodeWithRelations [
	self dbDo: [ :db | | node1 node2 rel1 rel2 rel3 rel4 |
		node1 := db createNodeLabeled: 'label1'.	
		node2 := db createNodeLabeled: 'label2'.
		rel1 := node1 relateTo: node2 typed: 'REL1'.
		rel2 := node1 relateTo: node2 typed: 'REL1'.
		rel3 := node2 relateTo: node1 typed: 'REL1'.
		rel4 := node2 relateTo: node1 typed: 'REL1'.
		
		self assert: (db countRelationshipsTyped: 'REL1') equals: 4.
		node1 deleteWithRelations.
		
		self assert: (db countRelationshipsTyped: 'REL1') equals: 0.
		node2 delete.
	
		self assert: (db countNodesLabeled: #('label1' 'label2')) equals: 0.
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testExistsRelationshipsFromNodes [
	self dbDo: [ :db | | nodeCreated1 nodeCreated2 outRelCreated1 outRelCreated2 outRelCreated3 outRelCreated4 outRelCreated5 outRelRetrieved1 outRelRetrieved2 outRelsRetrieved3 |
		nodeCreated1 := db createNodeLabeled: 'test'.
		nodeCreated2 := db createNodeLabeled: 'test'.
		outRelCreated1 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL1 properties: {#a->1}.
		outRelCreated2 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL2 properties: {}.
		outRelCreated3 := nodeCreated1 relateTo: nodeCreated2 typed: #REL3 properties: {}.
		outRelCreated4 := nodeCreated1 relateTo: nodeCreated2 typed: #REL3 properties: {}.
		outRelCreated5 := nodeCreated1 relateOneTo: nodeCreated2 typed: #REL1 properties: {#a->1}.
		
		nodeCreated2 properties: {#c->3}.
		
		self assert: (nodeCreated1 existsRelationshipTyped: #REL1).
		self assert: (nodeCreated1 existsOutRelationshipTyped: #REL1).
		self deny: (nodeCreated1 existsInRelationshipTyped: #REL1).
		self assert: (nodeCreated1 existsOutRelationshipTyped: #REL1 having: #a value: 1).
		self deny: (nodeCreated1 existsOutRelationshipTyped: #REL1 having: #a value: 2).
		self deny: (nodeCreated1 existsOutRelationshipTyped: #REL1 having: #b value: 1).
		
		self assert: (nodeCreated1 existsRelationshipTyped: #REL2).
		self assert: (nodeCreated1 existsOutRelationshipTyped: #REL2).
		self assert: (nodeCreated1 existsOutRelationshipTyped: #REL2 endNodeHaving: #c value: 3).
		self deny: (nodeCreated1 existsOutRelationshipTyped: #REL2 endNodeHaving: #c value: 4).
		self deny: (nodeCreated1 existsInRelationshipTyped: #REL2).
		
		self assert: (nodeCreated1 existsRelationshipTyped: #REL3).
		self assert: (nodeCreated1 existsOutRelationshipTyped: #REL3).
		self deny: (nodeCreated1 existsInRelationshipTyped: #REL3).
		
		outRelRetrieved1 := (nodeCreated1 outRelationshipsTyped: #REL1) first.
		outRelRetrieved2 := (nodeCreated1 outRelationshipsTyped: #REL2) first.
		outRelsRetrieved3 := nodeCreated1 outRelationshipsTyped: #REL3.
		
		self assert: outRelRetrieved1 delete equals: true.
		self assert: outRelRetrieved2 delete equals: true.
		outRelsRetrieved3 do: [ :each | 
			self assert: each delete equals: true.
		].
		self deny: (nodeCreated1 existsRelationshipTyped: #REL1).
		self deny: (nodeCreated1 existsRelationshipTyped: #REL2).
		self deny: (nodeCreated1 existsRelationshipTyped: #REL3).
		
		
	
		self assert: nodeCreated1 delete equals: true.
		self assert: nodeCreated2 delete equals: true.
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testGetPaginatedNodes [
	self dbDo: [ :db | | nodes |
		1 to: 10 do: [ :idx |
			db createNodeLabeled: 'labelA' properties: { #propA -> idx. #propB -> (10 - idx) }.	
		].
		self assert: (db countNodesLabeled: 'labelA') equals: 10.
		
		nodes := db nodesLabeled: 'labelA' where: [:node |] orderBy: [:node |node @ #propA] skip: 1 limit: 3.
		self assert: (nodes collect: [ :each | each @ #propA ]) asArray equals: #(2 3 4).
		nodes := db nodesLabeled: 'labelA' where: [:node |] orderBy: [:node |node @ #propB] skip: 1 limit: 3.
		self assert: (nodes collect: [ :each | each @ #propB ]) asArray equals: #(1 2 3).
		nodes := db nodesLabeled: 'labelA' where: [:node |] orderBy: [:node |(node @ #propB) desc] skip: 1 limit: 3.
		self assert: (nodes collect: [ :each | each @ #propB ]) asArray equals: #(8 7 6).
		nodes := db nodesLabeled: 'labelA' where: [:node |] orderBy: [:node |node @ #propA] skip: nil limit: 3.
		self assert: (nodes collect: [ :each | each @ #propA ]) asArray equals: #(1 2 3).
		nodes := db nodesLabeled: 'labelA' where: [:node |] orderBy: [:node |node @ #propA] skip: nil limit: nil.
		self assert: (nodes collect: [ :each | each @ #propA ]) asArray equals: #(1 2 3 4 5 6 7 8 9 10).
		nodes := db nodesLabeled: 'labelA' where: [:node | (node @ #propA) >= 5] orderBy: [:node |node @ #propA] skip: nil limit: nil.
		self assert: (nodes collect: [ :each | each @ #propA ]) asArray equals: #(5 6 7 8 9 10).
		nodes := db nodesLabeled: 'labelA' where: [:node | ((node @ #propA) >= 5) & ((node @ #propB) < 3)] orderBy: [:node |node @ #propA] skip: nil limit: nil.
		self assert: (nodes collect: [ :each | each @ #propA ]) asArray equals: #(8 9 10).
		
		db deleteNodesLabeled: 'labelA'.
		self assert: (db countNodesLabeled: 'labelA') equals: 0.
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testGetPaginatedRelationships [
	self dbDo: [ :db | | node1 node2 rels |
		node1 := db createNodeLabeled: 'labelA'.
		node2 := db createNodeLabeled: 'labelB'.
		1 to: 10 do: [ :idx |
			node1 relateTo: node2 typed: 'type1' properties: { #propA -> idx. #propB -> (10 - idx) }.	
		]. 
		self assert: (db countRelationshipsTyped: 'type1') equals: 10.
		
		rels := db relationshipsTyped: 'type1' where: [:rel |] orderBy: [:rel | rel @ #propA] skip: 1 limit: 3.
		self assert: (rels collect: [ :each | each @ #propA ]) asArray equals: #(2 3 4).
		rels := db relationshipsTyped: 'type1' where: [:node |] orderBy: [:node |node @ #propB] skip: 1 limit: 3.
		self assert: (rels collect: [ :each | each @ #propB ]) asArray equals: #(1 2 3).
		rels := db relationshipsTyped: 'type1' where: [:node |] orderBy: [:node |(node @ #propB) desc] skip: 1 limit: 3.
		self assert: (rels collect: [ :each | each @ #propB ]) asArray equals: #(8 7 6).
		rels := db relationshipsTyped: 'type1' where: [:node |] orderBy: [:node |node @ #propA] skip: nil limit: 3.
		self assert: (rels collect: [ :each | each @ #propA ]) asArray equals: #(1 2 3).
		rels := db relationshipsTyped: 'type1' where: [:node |] orderBy: [:node |node @ #propA] skip: nil limit: nil.
		self assert: (rels collect: [ :each | each @ #propA ]) asArray equals: #(1 2 3 4 5 6 7 8 9 10).
		rels := db relationshipsTyped: 'type1' where: [:node | (node @ #propA) >= 5] orderBy: [:node |node @ #propA] skip: nil limit: nil.
		self assert: (rels collect: [ :each | each @ #propA ]) asArray equals: #(5 6 7 8 9 10).
		rels := db relationshipsTyped: 'type1' where: [:node | ((node @ #propA) >= 5) & ((node @ #propB) < 3)] orderBy: [:node |node @ #propA] skip: nil limit: nil.
		self assert: (rels collect: [ :each | each @ #propA ]) asArray equals: #(8 9 10).
		
		node1 deleteWithRelations.
		node2 deleteWithRelations.
		self assert: (db countRelationshipsTyped: 'type1') equals: 0.
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testMergeNodes [
	self dbDo: [ :db | | node1 node2 node3 node4 node5 lastAccess node |
		node1 := db mergeNodeLabeled: 'label1'.
		node2 := db mergeNodeLabeled: 'label1'.
		self assert: node1 id = node2 id equals: true.
		node3 := db mergeNodeLabeled: 'label1' properties: {#counter -> 1}.
		node4 := db mergeNodeLabeled: 'label1' properties: {#counter -> 2}.
		node5 := db mergeNodeLabeled: 'label1' properties: {#counter -> 1}.
		self assert: node3 id = node4 id equals: false.
		self assert: node3 id = node5 id equals: true.
		
		lastAccess := 123.
		1 to: 3 do: [ :each |
			node := db mergeNodeLabeled: 'label2' havingAll: {#index -> each} onCreateSet: [:n | n @ 'index' to: each ] onMatchSet: [:n | n @ 'lastAccess' to: lastAccess ].
			self assert: (node @ #index) equals: each.
			self assert: (node @ #lastAccess) equals: nil.	
		].
		1 to: 3 do: [ :each |
			node := db mergeNodeLabeled: 'label2' havingAll: {#index -> each} onCreateSet: [:n | n @ 'index' to: each * 2 ] onMatchSet: [:n | n @ 'lastAccess' to: lastAccess ].
			self assert: (node @ #index) equals: each.
			self assert: (node @ #lastAccess) equals: 123.	
		].

		db deleteNodesLabeled: 'label1'.
		self assert: (db countNodesLabeled: 'lanel1') equals: 0.
		db deleteNodesLabeled: 'label2'.
		self assert: (db countNodesLabeled: 'label2') equals: 0.
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testOrphanedNodes [
	self dbDo: [ :db | | node1 node2 rel1 rel2 orphanedNodes |
		node1 := db createNodeLabeled: 'label1'.
		node2 := db createNodeLabeled: 'label1'.
		rel1 := node1 relateTo: node2 typed: 'type1'.
		rel2 := node1 relateTo: node2 typed: 'type1'.
		
		self assert: (node1 outRelationshipsTyped: 'type1') size equals: 2.
		self assert: (node2 outRelationshipsTyped: 'type1') size equals: 0.
		self assert: db orphanedNodes size equals: 0.
		
		rel1 delete.
		rel2 delete.
		
		self assert: (node1 outRelationshipsTyped: 'type1') size equals: 0.
		self assert: (node2 outRelationshipsTyped: 'type1') size equals: 0.
		
		orphanedNodes := db orphanedNodes.
		self assert: orphanedNodes size equals: 2.
		
		orphanedNodes do: [ :each | each delete ].
		self assert: (db countNodesLabeled: 'label1') equals: 0.
		self assert: (db countRelationshipsTyped: 'type1') equals: 0.
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testPropertiesOfNode [
	self dbDo: [ :db | | nodeCreated nodeRetrieved deletedResult deletedNodeRetrieved |
		nodeCreated := db createNodeLabeled: 'test' properties: {#a -> 1}.	
		nodeRetrieved := db nodeAt: nodeCreated id.
		self assert: (nodeRetrieved propertyAt: #a) equals: 1.
		nodeRetrieved propertyAt: #b put: 2.
		self assert: (nodeRetrieved propertyAt: #b) equals: 2.
		nodeRetrieved mergeProperties: {#b -> 3. #c -> 4}.
		self assert: (nodeRetrieved propertyAt: #a) equals: 1.
		self assert: (nodeRetrieved propertyAt: #b) equals: 3.
		self assert: (nodeRetrieved propertyAt: #c) equals: 4.
		nodeRetrieved properties: {#a -> 0}.
		self assert: (nodeRetrieved propertyAt: #a) equals: 0.
		self assert: (nodeRetrieved propertyAt: #b) equals: nil.
		self assert: (nodeRetrieved propertyAt: #c) equals: nil.
		nodeRetrieved removePropertyAt: #a.
		self assert: (nodeRetrieved propertyAt: #a) equals: nil.
		deletedResult := nodeRetrieved delete.
		self assert: deletedResult equals: true.
		deletedNodeRetrieved := db nodeAt: nodeCreated id.
		self assert: deletedNodeRetrieved equals: nil.
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testPropertiesOfRelationship [
	self dbDo: [ :db | | nodeCreated1 nodeCreated2 outRelCreated outRelRetrieved deletedResult deletedRelRetrieved |
		nodeCreated1 := db createNodeLabeled: 'test'.
		nodeCreated2 := db createNodeLabeled: 'test'.
		outRelCreated := db createInRelationshipTyped: 'REL1' fromNodeId: nodeCreated1 id toNodeId: nodeCreated2 id properties: {#a->1}.
		outRelRetrieved := db relationshipAt: outRelCreated id.
		self assert: (outRelRetrieved propertyAt: #a) equals: 1.
		outRelRetrieved propertyAt: #b put: 2.
		self assert: (outRelRetrieved propertyAt: #b) equals: 2.
		outRelRetrieved mergeProperties: {#b -> 3. #c -> 4}.
		self assert: (outRelRetrieved propertyAt: #a) equals: 1.
		self assert: (outRelRetrieved propertyAt: #b) equals: 3.
		self assert: (outRelRetrieved propertyAt: #c) equals: 4.
		outRelRetrieved properties: {#a -> 0}.
		self assert: (outRelRetrieved propertyAt: #a) equals: 0.
		self assert: (outRelRetrieved propertyAt: #b) equals: nil.
		self assert: (outRelRetrieved propertyAt: #c) equals: nil.
		outRelRetrieved removePropertyAt: #a.
		self assert: (outRelRetrieved propertyAt: #a) equals: nil.
		deletedResult := outRelRetrieved delete.
		self assert: deletedResult equals: true.
		deletedRelRetrieved := db relationshipAt: outRelRetrieved id.
		self assert: deletedRelRetrieved equals: nil.
		self assert: (db deleteNodeAt: nodeCreated1 id) equals: true.
		self assert: (db deleteNodeAt: nodeCreated2 id) equals: true.
	]
]

{ #category : 'testing' }
N4GraphDbTest >> testRelationshipNodes [
	self dbDo: [ :db | | node1 node2 inRel outRel |
		node1 := db mergeNodeLabeled: 'label1' properties: {#name -> 'name-in'}.
		node2 := db mergeNodeLabeled: 'label2' properties: {#name -> 'name-out'}.
		node1 relateOneTo: node2 typed: 'REL_OUT'.
		node2 relateOneTo: node1 typed: 'REL_IN'.
		
		inRel := (node1 inRelationshipsTyped: 'REL_IN') first.
		outRel := (node1 outRelationshipsTyped: 'REL_OUT') first.
		
		self assert: (inRel startNode @ 'name') equals: 'name-out'.
		self assert: (inRel endNode @ 'name') equals: 'name-in'.
		self assert: (inRel headNode @ 'name') equals: 'name-in'.
		self assert: (inRel tailNode @ 'name') equals: 'name-out'.
		
		self assert: (outRel startNode @ 'name') equals: 'name-in'.
		self assert: (outRel endNode @ 'name') equals: 'name-out'.
		self assert: (outRel headNode @ 'name') equals: 'name-out'.
		self assert: (outRel tailNode @ 'name') equals: 'name-in'.
		
		node1 deleteWithRelations.
		node2 deleteWithRelations.
		
		self assert: (db countNodesLabeled: 'label1') equals: 0.
		self assert: (db countNodesLabeled: 'label2') equals: 0.
		self assert: (db countRelationshipsTyped: 'REL_IN') equals: 0.
		self assert: (db countRelationshipsTyped: 'REL_OUT') equals: 0.
	]
]
