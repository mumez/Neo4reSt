testing
testReturnFromLargeCypher
	self dbDo: [ :db | 
		| padding mSecs cypher resp |
		padding := String new: 1024 * 100 withAll: Character space.
		mSecs := Time millisecondClockValue.
		cypher := ('WITH ', mSecs asString, ' as A', padding, 'RETURN A').
		resp := db queryByCypher: cypher.
		self assert: resp hasErrors not.
		self assert: (resp result data first at: 'row') equals: (Array with: mSecs).
	].