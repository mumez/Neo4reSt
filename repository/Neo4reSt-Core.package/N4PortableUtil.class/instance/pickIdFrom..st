read/write
pickIdFrom: uriString 
	"N4SqPortableUtil default pickIdFrom: 'http://localhost:7474/db/data/node/10'"
	"N4SqPortableUtil default pickIdFrom: 'http://localhost:7474/db/'"
	| sz |
	(sz := uriString size)
		to: 1
		by: -1
		do: [:idx | $/ = (uriString at: idx)
				ifTrue: [| chopped |
					chopped := uriString copyFrom: idx + 1 to: sz.
					^ chopped isEmpty
						ifTrue: [0]
						ifFalse: [chopped asInteger]]].
	^ -1