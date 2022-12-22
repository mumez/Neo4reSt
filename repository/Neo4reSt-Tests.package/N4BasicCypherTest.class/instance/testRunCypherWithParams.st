testing
testRunCypherWithParams
	self dbDo: [ :db | | resp cypherWithParams |
		resp := db runCypher: 'RETURN 1'.
		self assert: resp oneValue equals: 1.

		resp := db runCypher: (CyReturn of: 2 asCypherValue).
		self assert: resp oneValue equals: 2.

		resp := db runCypher: 'RETURN $p' arguments: {#p->3}.
		self assert: resp oneValue equals: 3.

		cypherWithParams := CyReturn of: 'p' asCypherParameter.
		resp := db runCypher: cypherWithParams arguments: {#p->4}.
		self assert: resp oneValue equals: 4.
	].