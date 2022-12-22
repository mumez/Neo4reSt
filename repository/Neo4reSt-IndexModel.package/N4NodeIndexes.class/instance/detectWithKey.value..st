actions
detectWithKey: key value: value
	| jsons |
	jsons := self httpClient getNodeWithIndex: self name key: key value: value.
	jsons isEmpty ifTrue: [^nil].
	^ (self db nodeClass json: jsons first) db: self db