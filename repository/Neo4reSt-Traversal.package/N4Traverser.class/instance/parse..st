private
parse: jsonElement
	self returnType = 'node' ifTrue: [^(self db nodeClass json: jsonElement) db: self db].
	self returnType = 'relationship' ifTrue: [^(self db relationshipClass json: jsonElement for: self startNode) db: self db].
	
	self flag: 'todo'.
	"self returnType = 'path' ifTrue: [].
	self returnType = 'fullpath' ifTrue: []."
	