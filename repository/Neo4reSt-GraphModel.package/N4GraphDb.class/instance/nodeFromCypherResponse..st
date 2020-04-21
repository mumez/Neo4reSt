private
nodeFromCypherResponse: resp
	| data nodeId node |
	resp hasErrors ifTrue: [ ^nil ].
	data := resp result data.
	data ifEmpty: [ ^nil ].
	nodeId := (data first at: 'row') first.
	node := self nodeClass id: nodeId.
	node db: self.
	^node