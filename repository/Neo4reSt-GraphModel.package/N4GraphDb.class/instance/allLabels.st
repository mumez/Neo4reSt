global operations
allLabels
	| resp |
	resp := self queryByCypher: 'MATCH (n)
WITH DISTINCT labels(n) as labels
UNWIND labels as label
RETURN distinct label
ORDER BY label'.
	^resp result data inject: OrderedCollection new into: [:sum :each | sum add: (each at: 'row') first; yourself].