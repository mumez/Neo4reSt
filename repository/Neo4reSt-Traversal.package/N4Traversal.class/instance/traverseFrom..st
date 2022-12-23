actions
traverseFrom: aNode
	"to do - implementing traverser"
	| json |
	json := self db httpClient traverseFrom: startNode id using: self.
	^N4Traverser json: json for: self