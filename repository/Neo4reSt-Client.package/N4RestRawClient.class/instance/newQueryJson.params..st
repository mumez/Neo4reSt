deprecated-builder
newQueryJson: queryString params: dictionary
	| jsonAssocs |
	jsonAssocs := OrderedCollection new.
	jsonAssocs add: ('query' -> queryString).
	jsonAssocs add: ('params' -> dictionary).
	^jsonAssocs