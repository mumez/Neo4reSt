testing
testGetPaginatedNodes
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