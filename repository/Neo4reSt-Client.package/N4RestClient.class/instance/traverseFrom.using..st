actions
traverseFrom: nodeId using: traversalDescription
	| resp |
	resp := self rawClient traverseFrom: nodeId using: traversalDescription.
	^self portableUtil readJsonFromResponse: resp
