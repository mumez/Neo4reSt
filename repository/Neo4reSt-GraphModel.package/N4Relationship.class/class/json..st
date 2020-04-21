instance creation
json: jsonObject
	| inst |
	inst := self new.
	inst id: (self portableUtil pickIdFrom: (jsonObject at: 'self')).
	inst type: (jsonObject at: 'type').
	inst startNodeId: (self portableUtil pickIdFrom: (jsonObject at: 'start')). 
	inst endNodeId: (self portableUtil pickIdFrom: (jsonObject at: 'end')). 
	
	^inst