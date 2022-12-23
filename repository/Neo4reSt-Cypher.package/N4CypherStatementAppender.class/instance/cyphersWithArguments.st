accessing
cyphersWithArguments
	^ self statements collect: [ :statement | 
		  statement isArray
			  ifTrue: [ 
				  { (self cypherStringFrom: statement first). statement second } ]
			  ifFalse: [ self cypherStringFrom: statement ] ]