loading
loadNodes: nodeDicts
	nodes := nodeDicts collect: [ :each | self loadNodeFrom: each ]