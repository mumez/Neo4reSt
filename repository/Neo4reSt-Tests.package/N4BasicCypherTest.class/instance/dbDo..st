private
dbDo: aBlock
	| db |
	db := N4GraphDb settings: self settings.
	[aBlock value: db ]
		ifCurtailed: [ db release ]