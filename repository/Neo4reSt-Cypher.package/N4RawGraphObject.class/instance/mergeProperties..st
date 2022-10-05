properties
mergeProperties: props
	props asDictionary keysAndValuesDo: [ :k :v |
		self propertyAt: k put: v 
	]