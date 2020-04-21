authentication
useAuthentication
	^self at: #authentication ifAbsentPut: [true] "From Neo4j 2.0 - true by default"