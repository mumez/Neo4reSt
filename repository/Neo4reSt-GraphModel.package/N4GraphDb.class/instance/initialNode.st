actions
initialNode
	^[self nodeAt: 0] on: N4NotFound do: [ :ex | self createNode ]