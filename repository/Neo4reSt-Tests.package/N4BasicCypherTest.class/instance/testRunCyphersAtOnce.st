testing
testRunCyphersAtOnce
	self dbDo: [ :db | | resp cyphersWithParam |
		resp := db runCyphers: #('RETURN 1' 'RETURN 2').
		self assert: resp allOneValues equals: #(1 2).
		
		cyphersWithParam := #(3 4) collect: [:each | CyReturn of: each asCypherValue].
		resp := db runCyphers: cyphersWithParam.
		self assert: resp allOneValues equals: #(3 4).
		
		resp := db runCyphersBy: [:cyphers |
			cyphers cypher: 'RETURN 10'.
			cyphers cypher: (CyReturn of: 20 asCypherValue).
			cyphers cypher: 'RETURN $p' arguments: {#p->30}.
			cyphers cypher: (CyReturn of: 'p' asCypherParameter) arguments: {#p->40}.
		].
		self assert: resp allOneValues equals: #(10 20 30 40).
	].