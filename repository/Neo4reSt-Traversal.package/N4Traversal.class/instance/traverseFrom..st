actions
traverseFrom: aNode
	"to do - implementing traverser"
	| json |
	json := self db restClient traverseFrom: startNode id using: self.
	^N4Traverser json: json for: self