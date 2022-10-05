properties
mergeProperties: props
	props keysAndValuesDo: [ :k :v |
		self propertyAt: k put: v 
	]