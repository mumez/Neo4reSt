accessing
restClient

	^ restClient ifNil: [restClient := N4RestClient settings: self settings]