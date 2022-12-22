testing
testGetPaginatedRelationships
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