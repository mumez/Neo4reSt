actions-deprecated
queryByLegacyCypher: queryString params: dictionary
	| resp |
	resp := self rawClient queryByLegacyCypher: queryString params: dictionary.
	^self portableUtil readJsonFromResponse: resp