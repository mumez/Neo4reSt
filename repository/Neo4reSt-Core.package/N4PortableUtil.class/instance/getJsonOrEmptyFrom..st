actions
getJsonOrEmptyFrom: urlString

	^[self getJsonFrom: urlString]
		on: N4NoContent
		do: [:ex | ex return: #()]