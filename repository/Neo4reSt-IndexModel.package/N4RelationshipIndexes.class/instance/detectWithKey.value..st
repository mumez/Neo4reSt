actions
detectWithKey: key value: value
	| jsons |
	jsons := self httpClient getRelationshipWithIndex: self name key: key value: value.
	jsons isEmpty ifTrue: [ ^ nil ].
	^ (self db relationshipClass json: jsons first) db: self db