actions-deprecated
queryByLegacyCypher: queryString params: dictionary
	| json jsonString |
	json := self newQueryJson: queryString params: dictionary.
	jsonString := self portableUtil jsonStringFrom: json.
	^ self portableUtil httpJsonPost: (self rootUri, 'cypher') content: jsonString