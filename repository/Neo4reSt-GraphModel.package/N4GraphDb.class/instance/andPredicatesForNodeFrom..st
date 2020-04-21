private
andPredicatesForNodeFrom: assocArray
	^String streamContents: [ :strm |
		assocArray do: [ :assoc |
			strm nextPutAll: (' n.{1}={2}' format: { assoc key. (self asValueParameter: assoc value) })
 		] separatedBy: [ strm nextPutAll: ' AND ' ]
	].