actions-query
queryByCyphersUsing: queryBuildingBlock
	| statements json jsonString |
	statements := queryBuildingBlock value: OrderedCollection new value: self.
	json := self newTransactionStatementsJson: statements asArray.
	jsonString := self portableUtil jsonStringFrom: json.
	^ self portableUtil httpJsonPost: (self rootUri, 'transaction', 'commit') content: jsonString