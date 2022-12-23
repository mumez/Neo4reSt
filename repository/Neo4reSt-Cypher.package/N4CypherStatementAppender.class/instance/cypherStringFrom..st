private
cypherStringFrom: stringOrCypherObject
	^ stringOrCypherObject isString ifTrue: [ stringOrCypherObject ] ifFalse: [ stringOrCypherObject cypherString ]