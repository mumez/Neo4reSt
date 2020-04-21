actions-deprecated
queryByLegacyCypher: queryString
	| resp |
	resp := self rawClient queryByLegacyCypher: queryString.
	^self portableUtil readJsonFromResponse: resp