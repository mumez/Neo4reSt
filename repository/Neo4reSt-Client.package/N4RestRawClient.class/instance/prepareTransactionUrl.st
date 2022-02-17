private
prepareTransactionUrl
	self supportV4 ifFalse: [ ^ self rootUri , 'transaction' , 'commit' ].
	
	^ self rootUri / 'db'/ self databaseName / 'tx'