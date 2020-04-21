releasing
close
	self restClient ifNotNil: [:cli | cli release]
	