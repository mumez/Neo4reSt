global operations
allLabels
	| resp |
	resp := self queryByCypher: 'MATCH (n)
WITH DISTINCT labels(n) as labels
UNWIND labels as label
RETURN distinct label
ORDER BY label'.
	^self firstFieldValuesOf: resp