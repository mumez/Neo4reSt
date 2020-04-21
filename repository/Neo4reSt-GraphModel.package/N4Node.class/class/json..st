instance creation
json: jsonObject
	| inst |
	inst := self new.
	inst id: (self portableUtil pickIdFrom: (jsonObject at: 'self')).
	inst properties: (jsonObject at: 'data').
	^inst