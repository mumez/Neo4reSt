private
firstFieldValuesOf: aCypherResponse
	^aCypherResponse result data inject: OrderedCollection new 
		into: [:sum :each | sum add: ((each at: 'row') first); yourself].