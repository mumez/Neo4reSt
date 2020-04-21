enumeration
columnsAndDataDo: aBlock
	| clms |
	clms := self columns.
	self data do: [:eachRow |
		1 to: clms size do: [:idx |
			aBlock value: (clms at: idx) value: (eachRow at: idx).	
		]
	]